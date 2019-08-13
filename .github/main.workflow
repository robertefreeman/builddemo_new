workflow "Build and Push" {
  on = "push"
  resolves = ["Trivy Scanner"]
}

action "Docker Build" {
  uses = "actions/docker/cli@86ab5e854a74b50b7ed798a94d9b8ce175d8ba19"
  args = "build -t robertfreeman/builddemo ."
}

action "Docker Login" {
  uses = "actions/docker/login@86ab5e854a74b50b7ed798a94d9b8ce175d8ba19"
  needs = ["Docker Build"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  uses = "actions/docker/cli@86ab5e854a74b50b7ed798a94d9b8ce175d8ba19"
  needs = ["Docker Login"]
  args = "push robertfreeman/builddemo"
}

action "Trivy Scanner" {
  uses = "actions/docker/cli@86ab5e854a74b50b7ed798a94d9b8ce175d8ba19"
  needs = ["Docker Push"]
  args = "run --rm knqyf263/trivy robertfreeman/builddemo"
}
