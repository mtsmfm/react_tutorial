CommentList = React.createClass
  render: ->
    commentNodes = @props.data.map (comment) ->
      <Comment author={comment.author}>
        {comment.text}
      </Comment>
    <div className="commentList">
      {commentNodes}
    </div>

CommentForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    author = @refs.author.getDOMNode().value.trim()
    text   = @refs.text.getDOMNode().value.trim()
    return unless text && author

    @props.onCommentSubmit({author, text})
    @refs.author.getDOMNode().value = ''
    @refs.text.getDOMNode().value = ''

  render: ->
    <form className="commentForm" onSubmit={@handleSubmit}>
      <input type="text" placeholder="Your name" ref="author" />
      <input type="text" placeholder="Say something..." ref="text"/>
      <input type="submit" value="Post" />
    </form>

CommentBox = React.createClass
  handleCommentSubmit: (comment) ->
  loadCommentsFromServer: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      success: ((data) ->
        @setState(data: data)
      ).bind(@)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
      ).bind(@)
  getInitialState: ->
    {data: []}
  componentDidMount: ->
    @loadCommentsFromServer()
    setInterval(@loadCommentsFromServer, @props.pollInterval)
  render: ->
    <div className="commentBox">
      <h1>Comments</h1>
      <CommentList data={@state.data}/>
      <CommentForm onCommentSubmit={@handleCommentSubmit}/>
    </div>

converter = new Showdown.converter()
Comment = React.createClass
  render: ->
    rawMarkup = converter.makeHtml(@props.children.toString())
    <div className="comment">
      <h2 className="commentAuthor">
        {@props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>

$ ->
  React.render(
    <CommentBox url="home/comments.json" pollInterval={2000}/>,
    document.getElementById('content')
  )
