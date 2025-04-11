# Package Groups

This repo contains, per eco system, a list of what we call package groups, which
are a bunch of packages (often maintained in a monorepo) that are released in
lockstep and should be updated together

We're planning on adding a bit of tooling to this, to make it easier to
contribute and verify these groups.

## Contributing

Feel free to create PRs for package groups you think are missing. Please make
sure your contribution passes the following checks:

- The JSON needs to validate.
- All packages are released in lockstep, with identical version numbers.
  Otherwise this mechanism will not work in Depfu.
- The packages are publicly available. We're working on a mechnism for creating
  private package groups, but they will not end up in this repo, for hopefully
  obvious reasons.

## Format

Here's an example:

```json
{
  "solidus":
  [
    "solidus",
    "solidus_api",
    "solidus_backend",
    "solidus_core",
    "solidus_frontend",
    "solidus_sample"
  ]
}
```

The whole list is a hash (or rather JSON object). The key is a unique but
arbitrary group name. Usually, if there's a "root" package, such as `solidus` in
this case, that's a good group name, so please don't name your group
"florpmangle" just because you can.

Following is an array of package names.

## Tooling

If you have a ruby toolchain, you can use the `find_package_group` utility:

`bin/find_package_group [owner]/[repo]`

that will scan a typical npm mono repo for packages that can be grouped. This
tool needs some love, specifically a way to search on a release tag and with a
specific version to increase the chance of finding all packages.

For this to work you need to add `.env` file that contains an env variable
called `GITHUB_ACCESS_TOKEN` with a personal access token for GitHub to lift
your API call limit (As the tool is doing lots of calls to the GitHub API)

There's also a rake task that will validate the format of the JSON files, simply
call `rake`.

This is also running in GitHub actions.

## Inspiration, prior art

For a while, when greenkeeper wasn't yet sold to Snyk, we've used
[this](https://github.com/greenkeeperio/monorepo-definitions) repo as a basis
for the grouping of npm packages, so thanks to our friends in Berlin to come up
with this.

## License

Copyright Florian Munz und Jan Krutisch

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

See [LICENSE](LICENSE) or [https://www.apache.org/licenses/LICENSE-2.0](https://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
