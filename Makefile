DOCKER_REPO      = lfurrea/lolcat
TARGET           ?= darwin
ARCH             ?= amd64
SRC              = $(shell find . -type f -name '*.go' -not -path "./vendor/*")
OUT              = build

export GO111MODULE=on

default: build

build: 	test
	     	@echo "== Build =="
	     	@mkdir -p $(OUT)
			 	CGO_ENABLED=0 GOOS=$(TARGET) GOARCH=$(ARCH) go build -o $(OUT)/lolcat -ldflags="-s -w" -v main.go

test:
			 	@echo "== Test =="
			 	gofmt -s -l -w $(SRC)

clean:
				@echo "== Cleaning =="
				rm -rf build/

docker:
				@echo "== Building Docker Image =="
				docker build . -t $(DOCKER_REPO):${DOCKER_IMAGE_TAG}
