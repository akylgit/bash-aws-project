import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')

    # Get all EBS snapshots
    snapshots_response = ec2.describe_snapshots(OwnerIds=['self'])

    # Get all active EC2 instance IDs
    instances_response = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    active_instance_ids = set()
    for reservation in instances_response['Reservations']:
        for instance in reservation['Instances']:
            active_instance_ids.add(instance['InstanceId'])

    # Delete snapshots that are not attached or associated with volumes that don't exist or are unattached
    for snapshot in snapshots_response['Snapshots']:
        snapshot_id = snapshot['SnapshotId']
        volume_id = snapshot.get('VolumeId')

        if not volume_id:
            # Snapshot not attached to any volume
            ec2.delete_snapshot(SnapshotId=snapshot_id)
            print(f"Deleted EBS snapshot {snapshot_id} as it was not attached to any volume.")
        else:
            try:
                volume_response = ec2.describe_volumes(VolumeIds=[volume_id])
                volume_attachments = volume_response['Volumes'][0]['Attachments']
                if not volume_attachments:
                    # Volume exists but is not attached to any instance
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f"Deleted EBS snapshot {snapshot_id} as it was taken from a volume not attached to any running instance.")
            except ec2.exceptions.ClientError as e:
                if e.response['Error']['Code'] == 'InvalidVolume.NotFound':
                    # Volume doesn't exist, so delete the snapshot
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f"Deleted EBS snapshot {snapshot_id} as its associated volume was not found.")

    # Get all volumes owned by self
    volumes_response = ec2.describe_volumes(Filters=[{'Name': 'status', 'Values': ['available']}])

    # Delete unattached volumes (status 'available' means unattached)
    for volume in volumes_response['Volumes']:
        volume_id = volume['VolumeId']
        ec2.delete_volume(VolumeId=volume_id)
        print(f"Deleted unattached EBS volume {volume_id}.")

    return {
        "message": "Deleted unused snapshots and unattached volumes successfully."
    }

