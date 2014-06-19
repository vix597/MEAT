
class @RedmineEventHandler

    constructor: (@opts) ->


    handle: (obj) ->
        $li = $("<span>").append(
            $("<span class='label label-primary'>Redmine</span>")
        ).append(' ').append(
            $("<a target='_blank'>").attr('href', obj.project_url).text(obj.project_name)
        ).append(': ')

        if obj.id == 'redmine.issue.create'
            $li.append(
                $("<a target='_blank'>").attr('href', obj.author_url).text(obj.author_name)
            ).append(' reported issue ').append(
                $("<a>").attr('href', obj.issue_url).text("#" + obj.issue_id + " - " + obj.issue_title)
            )

        @opts.panel.add($li, obj, true)
