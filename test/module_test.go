package main

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"regexp"
	"testing"
)

func TestModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	exampleArn := terraform.Output(t, terraformOptions, "cluster_arn")

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:ecs:eu-west-2:[0-9]{12}:cluster/hmpps-test-unit-test`), exampleArn)
}
