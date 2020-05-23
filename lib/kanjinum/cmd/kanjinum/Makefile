REPO_BIN=/Users/yakamon/go/src/github.com/yakamon/shconf/bin
CMD=kanjinum

GOOS=darwin
GOARCH=amd64


all: $(CMD) move

$(CMD): $(CMD)
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $@ $<
	chmod a+x $(CMD)

move:
	mv $(CMD) $(REPO_BIN)/$(CMD)
