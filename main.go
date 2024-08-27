package main

import (
	"github.com/patrickcping/dvtf-pingctl/cmd"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
)

var (
	// these will be set by the goreleaser configuration
	// to appropriate values for the compiled binary
	version string = "dev"

	// goreleaser can also pass the specific commit if you want
	commit string = "none"
)

func main() {
	l := logger.Get()

	l.Debug().Msg("Starting dvtf")
	cmd.SetVersionInfo(version, commit)
	cmd.Execute()
}
