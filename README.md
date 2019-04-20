# buildpack-scout

This is a utility designed to help figure out the union of binaries across a set of [cloudfoundry](https://github.com/cloudfoundry) buildpacks based on a user supplied set of release tags.

It relies on the [GitHub releases API](https://developer.github.com/v3/repos/releases/#get-a-release-by-tag-name).

Right now it's hardcoded and, therefore, limited to the [ruby-buildpack](https://github.com/cloudfoundry/ruby-buildpack) and and searches for ruby, jruby, and bundler binary versions. I'll expand it at some point to take user specified binaries and a repo, so it should work for most CF buildpacks - assuming their body format is consistent and doesn't change :wink:. Fortunately CF is quite consistent about formatting their release descriptions.

## Quickstart

Just clone the repo and execute `ruby recon.rb` and follow the prompts. Here are some [example release tags](https://github.com/cloudfoundry/ruby-buildpack/releases).

```
$ cd buildpack-scout
$ ruby recon.rb
Enter comma separated version tags:
v1.7.18,v1.7.22,v1.7.33

Tag(s) searched successfully: v1.7.18, v1.7.22, v1.7.33
Tag search failures: v1.7.10000

Binary Set Unions:
bundler: 1.16.1, 1.16.3, 1.17.3, 2.0.1
ruby: 2.2.10, 2.2.9, 2.3.6, 2.3.7, 2.3.8, 2.4.3, 2.4.4, 2.4.5, 2.5.0, 2.5.1, 2.5.3, 2.6.0, 2.6.1
jruby: 9.1.17.0, 9.2.0.0, 9.2.6.0
```
