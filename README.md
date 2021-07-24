# nvim-docker

A simple docker container for working on different nvim configs. It's useful for working on your config, or a PR, without destroying the editor that you're currently using.

```sh
./build.sh
./run.sh foo
```

This will create an untracked "foo" directory in the repo root. Inside it will contain the .local and .config data directories bound to the container. Each working directory that you create is essentially an isolated configuraton.
