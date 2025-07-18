#!/bin/bash

REGION="us-east-1"
SNAPSHOT_AGE_DAYS=0

echo "🔥 Deleting unused EBS volumes..."
UNUSED_VOLUMES=$(aws ec2 describe-volumes \
  --region "$REGION" \
  --filters Name=status,Values=available \
  --query "Volumes[].VolumeId" \
  --output text)

for VOL in $UNUSED_VOLUMES; do
  echo "Deleting volume: $VOL"
  aws ec2 delete-volume --region "$REGION" --volume-id "$VOL"
done

echo ""
echo "🔥 Deleting old snapshots..."
OLD_DATE=$(date -u -d "-$SNAPSHOT_AGE_DAYS days" +"%Y-%m-%dT%H:%M:%SZ")

SNAPSHOTS=$(aws ec2 describe-snapshots \
  --region "$REGION" \
  --owner-ids self \
  --query "Snapshots[?StartTime<='$OLD_DATE'].SnapshotId" \
  --output text)

for SNAP in $SNAPSHOTS; do
  echo "Deleting snapshot: $SNAP"
  aws ec2 delete-snapshot --region "$REGION" --snapshot-id "$SNAP"
done

