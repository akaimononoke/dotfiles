alias hclip='hclip'

function hclip() {
	history -n 1 | tail -r | peco | pbcopy
}
