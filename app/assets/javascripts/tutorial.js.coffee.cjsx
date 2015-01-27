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
  getInitialState: ->
    {data: []}
  componentDidMount: ->
    $.ajax
      url: @.props.url
      dataType: 'json'
      success: ((data) ->
        @.setState(data: data)
      ).bind(@)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
      ).bind(@)

  render: ->
    <div className="commentBox">
      <h1>Comments</h1>
      <CommentList data={@.state.data}/>
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
    <CommentBox url="home/comments.json"/>,
    document.getElementById('content')
  )
