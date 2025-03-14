# GitHub Action for Hugo

An Action to run [`hugo`](https://gohugo.io/) commands.

This example runs on pushes to the master branch and will run `hugo ` to build your site.

Check out entrypoint.sh to see exactly what it does.

## Usage

```yaml
on:
  push:
    branches:
      - master
name: Deploy
jobs:
  build:
    name: Build & Deploy
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Hugo
      uses: freeformz/hugo-action@master
      with:
        args: --enableGitInfo
    - name: S3 sync
      uses: docker://amazon/aws-cli:2.0.7
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      with:
        args: s3 sync --delete ./public s3://icanhazdowntime.org
    - name: Kick Cloudfront
      uses: docker://amazon/aws-cli:2.0.7
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      with:
        args: cloudfront create-invalidation --distribution-id ${{ secrets.CloudFrontDistributionID }} --paths /*
```
