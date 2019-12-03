// Based on:
// https://gist.github.com/islishude/6ccd1fbf42d1eaac667d6873e7b134f8

export default class Caret {
  constructor(target) {
    console.log("Initializing Caret")
    this.isContentEditable = target && target.contentEditable
    this.target = target
  }

  getPos() {
    console.log("Getting pos!")
    if (this.isContentEditable) {
      this.target.focus()
      let _range = document.getSelection().getRangeAt(0)
      let range = _range.cloneRange()
      range.selectNodeContents(this.target)
      range.setEnd(_range.endContainer, _range.endOffset)
      let count = range.toString().length
      console.log("count is: ", count)
      return count
    }
    return this.target.selectionStart
  }

  setPos(pos) {
    console.log("Setting pos to ", pos)
    if (this.isContentEditable) {
      this.target.focus()
      let sel = document.getSelection()
      console.log(sel)
      sel.collapse(this.target, pos)
      return
    }
    this.target.setSelectionRange(pos, pos)
  }
}
