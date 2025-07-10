.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: lint
lint: fmt
	docker run --rm -v $(PWD):/app -v ~/.cache/golangci-lint/v1.58.0:/root/.cache -w /app golangci/golangci-lint:v1.58.0 golangci-lint run

.PHONY: test
test:
	go test -count=1 -p 1 ./... | grep -v "no test files"
