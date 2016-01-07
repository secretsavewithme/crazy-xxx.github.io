CommentBox = React.createClass
  render: ->
    <div className="commentBox">
      Hello, world! I am a CommentBox.
    </div>

ReactDOM.render(
  <CommentBox />,
  document.getElementById('content')
)
