#!/usr/bin/env python
from constructs import Construct
from cdktf import App, TerraformStack


class StaticWebStack(TerraformStack):
    def __init__(self, scope: Construct, id: str):
        super().__init__(scope, id)

        # define resources here


app = App()
StaticWebStack(app, "static-web-stack")

app.synth()
