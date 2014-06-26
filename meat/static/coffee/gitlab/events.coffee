
class Event
    constructor: (obj) ->
        @id = obj.id
        @timestamp = obj.timestamp

    this.create = (obj) ->
        if obj.id == 'gitlab.push'
            return new PushEvent(obj)
        return new Gitlab.Event(obj)

    render: ($e) ->
        $e.append(
            $("<span class='label label-success'>Gitlab</span>")
        ).append(' ')


class PushEvent extends Event
    constructor: (obj) ->
        super(obj)
        @before = obj.before
        @after = obj.after
        @ref = obj.ref
        @user = new Gitlab.User({
            id: obj.user_id,
            name: obj.user_name
        })

        @repository = new Gitlab.Repository(obj.repository)
        @commit_count = obj.total_commits_count
        parts = @ref.split('/')
        @branch = if parts.length then parts[parts.length-1] else '<null>'

    render: ($e) ->
        super($e).append(
            @repository.render()
        ).append(' ').append(
            @user.render()
        ).append(
            " pushed "
        ).append(
            $("<span class='badge'>#{@commit_count}</span>")
        ).append(
            " commits to "
        ).append(
            $("<span class='label label-info'>#{@branch}</span>")
        )

Gitlab.Event = Event

Gitlab.init = (opts) ->
    opts.dispatch.register('gitlab', Gitlab.Event)
