#!/bin/bash

tag=${GITHUB_REF/*tags\//}
echo ${tag/.*/}
