

class User
    constructor: (obj) ->
        if obj
            @name = obj.name
            @url = obj.url
        else
            @name = "Anonymous"
            @url = null

    render: () ->
        $e = null
        if @url
            $e = $("<a target='_blank'>").text(@name).attr('href', @url)
        else
            $e = $("<em>").text(@name)
        return $e

class Project
    constructor: (obj) ->
        @name = obj.name
        @url = obj.url
        @identifier = obj.identifier

    render: () ->
        return $("<a target='_blank'>").attr('href', @url).append(
            $("<span class='badge'>").text(@name)
        )

class Issue
    constructor: (obj) ->
        @title = obj.title
        @id = obj.id
        @url = obj.url

    render: () ->
        return $("<a target='_blank'>").attr('href', @url).text(
            "##{@id} - #{@title}"
        )


Redmine.Issue = Issue
Redmine.User = User
Redmine.Project = Project
