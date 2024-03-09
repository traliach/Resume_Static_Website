#!/usr/bin/env python
import mimetypes
from pathlib import Path

from constructs import Construct
from cdktf import App, TerraformStack
from cdktf_cdktf_provider_google.provider import GoogleProvider
from cdktf_cdktf_provider_google.storage_bucket import StorageBucket
from cdktf_cdktf_provider_google.storage_bucket_iam_binding import StorageBucketIamBinding
from cdktf_cdktf_provider_google.storage_bucket_object import StorageBucketObject


def upload_files(stack, folder_path: str, bucket: StorageBucket):
    absolute_folder_path = f"{Path(folder_path).absolute()}"
    # Upload the files to the bucket
    pathlist = Path(absolute_folder_path).glob('**/*')  # Get all files in the folder
    for path in pathlist:
        # Ensure the path is a file
        if path.is_file():
            # Guess the mime type based of the file
            mime_type, _ = mimetypes.guess_type(path)
            if mime_type is None:
                mime_type = 'application/octet-stream'
            # Upload the file to the bucket
            file_key = f"{path.stem}{path.suffix}"
            object_name = f"{path.relative_to(absolute_folder_path)}"
            StorageBucketObject(
                stack, file_key,
                bucket=bucket.name,
                name=object_name,  # Object name in the bucket
                source=path.as_posix(),  # Local file path
                content_type=mime_type,
            )


def google_provide_bucket(stack, id, project):
    # Configure the Google provider
    GoogleProvider(stack, 'google', project=project, region='us-central1')

    # Create the storage bucket for the static website
    bucket = StorageBucket(
        stack, f'{id}-bucket',
        name=f'{project}-{id}',
        location='US',
        website={
            'main_page_suffix': 'index.html',
            'not_found_page': '404.html'
        },
        force_destroy=True,
    )

    # Make the bucket publicly readable
    StorageBucketIamBinding(
        stack, 'storage-bucket-iam-binding',
        bucket=bucket.name,
        role='roles/storage.objectViewer',
        members=['allUsers']
    )

    return bucket


class StaticWebStack(TerraformStack):
    def __init__(self, scope: Construct, id: str, project: str, folder_path: str):
        super().__init__(scope, id)

        # define resources here

        bucket = google_provide_bucket(self, id, project)
        upload_files(self, folder_path, bucket)


if __name__ == '__main__':
    stack_id = "static-web-stack" # the stack id
    project = 'the-name-of-the-google-project' # The name of the google project
    bucket_name = f'{project}-static-website' # The name of the bucket
    folder_path = '../my_resume' # The path to the folder containing the files to upload
    app = App()
    StaticWebStack(app, stack_id, project, folder_path)

    app.synth()
