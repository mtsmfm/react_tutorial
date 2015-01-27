CommentList = React.createClass
  render: ->
    <div className="commentList">
      <Comment author="Pete Hunt">This is one comment</Comment>
      <Comment author="Jordan Walke">This is *another* comment</Comment>
    </div>

CommentForm = React.createClass
  render: ->
    <div className="commentForm">
      Hello, world! I am a CommentForm.
    </div>

CommentBox = React.createClass
  render: ->
    <div className="commentBox">
      <h1>Comments</h1>
      <CommentList />
      <CommentForm />
    </div>

converter = new Showdown.converter()
Comment = React.createClass
  render: ->
    rawMarkup = converter.makeHtml(@.props.children.toString())
    <div className="comment">
      <h2 className="commentAuthor">
        {@.props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>

$ ->
  React.render(
    <CommentBox />,
    document.getElementById('content')
  )
