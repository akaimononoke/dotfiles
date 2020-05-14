GOOS=darwin
GOARCH=amd64

CMD_NAME=continuous_timer

all: $(CMD_NAME) move

$(CMD_NAME): $(CMD_NAME).go
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $@ $<
	chmod a+x $(CMD_NAME)

move:
	mv $(CMD_NAME) ../../bin/$(CMD_NAME)
