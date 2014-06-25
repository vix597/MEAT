

class Event
    constructor: (obj) ->
        @project = new Redmine.Project(obj.project)
        @id = obj.id
        @timestamp = obj.timestamp

    this.create = (obj) ->
        if obj.id.startsWith("redmine.issue")
            return new IssueEvent(obj)
        return new Event(obj)

    render: ($e) ->
        $e.append(
            $("<span class='label label-primary'>Redmine</span>")
        ).append(' ')


class IssueEvent extends Event
    constructor: (obj) ->
        super(obj)
        @issue = new Redmine.Issue(obj.issue)

        if 'author' of obj
            @author = new Redmine.User(obj.author)
        if 'status' of obj
            @status = obj.status
        if 'assigned_to' of obj
            @assigned_to = new Redmine.User(obj.assigned_to)
        if 'tracker' of obj
            @tracker = obj.tracker

    render: ($e) ->
        super($e).append(
            @project.render()
        ).append(' ')

        if @tracker
            cls = null
            if @tracker == 'Bug'
                cls = 'label-danger'
            else if @tracker == 'Feature'
                cls = 'label-info'
            else if @tracker == 'Support'
                cls = 'label-warning'
            else
                cls = 'label-default'
            $e.append(
                $("<span class='label #{cls}'>").text(@tracker)
            ).append(' ')

        if @id == 'redmine.issue.create'
            $e.append(
                @author.render()
            ).append(" reported issue ").append(
                @issue.render()
            )
        else if @id == 'redmine.issue.comment'
            $e.append(
                @author.render()
            ).append(" commented on issue ").append(
                @issue.render()
            )
        return $e

Redmine.Event = Event
Redmine.init = (opts) ->
    opts.dispatch.register('redmine', Redmine.Event)
