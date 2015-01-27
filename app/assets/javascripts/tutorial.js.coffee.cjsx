CommentList = React.createClass
  render: ->
    commentNodes = @.props.data.map (comment) ->
      <Comment author={comment.author}>
        {comment.text}
      </Comment>
    <div className="commentList">
      {commentNodes}
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
      <CommentList data={@.props.data}/>
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

data = [
  {author:"Pete Hunt", text: "This is one comment"},
  {author:"Jordan Walke", text: "This is *another* comment"}
]

$ ->
  React.render(
    <CommentBox data={data}/>,
    document.getElementById('content')
  )
