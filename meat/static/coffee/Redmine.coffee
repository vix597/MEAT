
class @RedmineEventHandler

    constructor: (@opts) ->


    handle: (obj) ->
        $li = $("<span>").append(
            $("<span class='label label-primary'>Redmine</span>")
        ).append(' ').append(
            $("<a target='_blank'>").attr('href', obj.project_url).append(
                $("<span class='badge'>").text(obj.project_name)
            )
        ).append(' ')

        if obj.id.startsWith('redmine.issue')
            $li.append(
                $("<a target='_blank'>").attr('href', obj.author_url).text(obj.author_name)
            ).append(' ')
            @handleIssue(obj, $li)
        @opts.panel.add($li, obj)

    handleIssue: (obj, $li) ->
        if obj.id == 'redmine.issue.create'
            $li.append('reported issue ').append(
                $("<a>").attr('href', obj.issue_url).text("#" + obj.issue_id + " - " + obj.issue_title)
            )
        else if obj.id == 'redmine.issue.comment'
            $li.append('commented on issue ').append(
                $("<a>").attr('href', obj.issue_url).text("#" + obj.issue_id + " - " + obj.issue_title)
            )
        else if obj.id == 'redmine.issue.status'
            if obj.status == 'Resolved'
                $li.append("resolved")
            else if obj.status == 'Closed'
                $li.append('closed')
            else if obj.status == 'Rejected'
                $li.append('rejected')
            else if obj.status == 'In Progress'
                $li.append('began work on')
            else
                $li.append(obj.status)
            $li.append(' issue ')
            $li.append(
                $("<a>").attr('href', obj.issue_url).text("#" + obj.issue_id + " - " + obj.issue_title)
            )
