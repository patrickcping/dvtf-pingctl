package main

import (
	"github.com/patrickcping/dvtf-pingctl/cmd"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
)

func main() {
	l := logger.Get()

	l.Debug().Msg("Starting dvtf")

	cmd.Execute()
}
