#!/bin/bash

REGION="us-east-1"
THRESHOLD=10  # CPU utilization threshold (%)
SNAPSHOT_AGE_DAYS=0

echo "🔍 Checking for underutilized EC2 instances in $REGION..."

INSTANCE_IDS=$(aws ec2 describe-instances \
  --region "$REGION" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "No EC2 instances found in region $REGION."
else
  for INSTANCE_ID in $INSTANCE_IDS; do
    echo "Checking instance: $INSTANCE_ID"

    CPU_UTILIZATION=$(aws cloudwatch get-metric-statistics \
      --region "$REGION" \
      --metric-name CPUUtilization \
      --start-time "$(date -u -d '-7 days' +'%Y-%m-%dT%H:%M:%SZ')" \
      --end-time "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
      --period 3600 \
      --namespace AWS/EC2 \
      --statistics Average \
      --dimensions Name=InstanceId,Value="$INSTANCE_ID" \
      --query "Datapoints[].Average" \
      --output text)

    if [ -z "$CPU_UTILIZATION" ]; then
      echo "  ⚠️ No CPU data for $INSTANCE_ID"
      continue
    fi

    TOTAL=0
    COUNT=0
    for VALUE in $CPU_UTILIZATION; do
      TOTAL=$(echo "$TOTAL + $VALUE" | bc)
      COUNT=$((COUNT + 1))
    done

    AVERAGE=$(echo "scale=2; $TOTAL / $COUNT" | bc)
    echo "  Avg CPU for $INSTANCE_ID: $AVERAGE%"

    if (( $(echo "$AVERAGE < $THRESHOLD" | bc -l) )); then
      echo "  ⚠️ Underutilized (avg < $THRESHOLD%)"
    else
      echo "  ✅ Utilized well"
    fi
  done
fi

echo ""
echo "🔍 Checking for unused EBS volumes..."
UNUSED_VOLUMES=$(aws ec2 describe-volumes \
  --region "$REGION" \
  --filters Name=status,Values=available \
  --query "Volumes[].VolumeId" \
  --output text)

if [ -z "$UNUSED_VOLUMES" ]; then
  echo "No unused EBS volumes found."
else
  echo "⚠️ Unused volumes:"
  for VOL in $UNUSED_VOLUMES; do
    echo "- $VOL"
  done
fi

echo ""
echo "🔍 Checking for old snapshots..."
OLD_DATE=$(date -u -d "-$SNAPSHOT_AGE_DAYS days" +"%Y-%m-%dT%H:%M:%SZ")

SNAPSHOTS=$(aws ec2 describe-snapshots \
  --region "$REGION" \
  --owner-ids self \
  --query "Snapshots[?StartTime<='$OLD_DATE'].SnapshotId" \
  --output text)

if [ -z "$SNAPSHOTS" ]; then
  echo "No snapshots older than $SNAPSHOT_AGE_DAYS days."
else
  echo "⚠️ Snapshots older than $SNAPSHOT_AGE_DAYS days:"
  for SNAP in $SNAPSHOTS; do
    echo "- $SNAP"
  done
fi

