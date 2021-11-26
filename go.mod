module github.com/karmanyaahm/up_rewrite

go 1.17

require (
	github.com/caarlos0/env/v6 v6.6.2
	github.com/hakobe/paranoidhttp v0.2.0
	github.com/komkom/toml v0.0.0-20210317065440-24f427ca88cc
	github.com/patrickmn/go-cache v2.1.0+incompatible
	github.com/stretchr/testify v1.7.0
)

require (
	github.com/davecgh/go-spew v1.1.0 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c // indirect
)

replace github.com/hakobe/paranoidhttp => github.com/karmanyaahm/paranoidhttp v0.2.1-0.20210628044206-c40d6edc4d56
