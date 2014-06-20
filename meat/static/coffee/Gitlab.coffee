
class @GitlabEventHandler
    constructor: (@opts) ->


    handle: (obj) ->
        $e = $("<span>")
        $e.append(
            $("<span class='label label-success'>Gitlab</span>")
        ).append(' ').append(
            $("<a target='_blank'>").attr('href', obj.repository.homepage).append(
                $("<span class='badge'>").text(obj.repository.name)
            )
        ).append(' ').append(
            $("<a href='#' target='_blank'>").text(obj.user_name)
        ).append(
            " pushed " + obj.commits.length + " commits to branch "
        ).append(
            $("<a href='#' target='_blank'>").text(obj.ref)
        )

        @opts.panel.add($e, obj)


