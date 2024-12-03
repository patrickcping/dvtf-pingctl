package generate

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

func sanitiseResourceName(name string) string {
	return strings.ToLower(regexp.MustCompile(`[^\w]+`).ReplaceAllString(name, "_"))
}

func sanitiseStringField(value string) string {
	if !strings.Contains(value, `\"`) {
		value = strings.ReplaceAll(value, `"`, `\"`)
	}

	re := regexp.MustCompile(`\r?\n`)
	value = re.ReplaceAllString(value, "\\n")

	return strings.TrimSpace(value)
}

func sanitiseStringFieldPtr(value *string) *string {
	if value == nil || *value == "" {
		return nil
	}

	returnVar := sanitiseStringField(*value)
	return &returnVar
}

func ensureDirExists(dirPath string) error {
	// Check if the directory exists
	_, err := os.Stat(dirPath)
	if os.IsNotExist(err) {
		// Directory does not exist, create it
		err = os.MkdirAll(dirPath, os.ModePerm)
		if err != nil {
			return fmt.Errorf("failed to create directory %q: %v", dirPath, err)
		}
	} else if err != nil {
		// An error other than "directory does not exist" occurred
		return fmt.Errorf("failed to check directory %q: %v", dirPath, err)
	}
	return nil
}
