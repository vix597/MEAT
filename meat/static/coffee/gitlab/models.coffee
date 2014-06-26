
class Repository
    constructor: (obj) ->
        @name = obj.name
        @url = obj.url
        @homepage = obj.homepage

    render: () ->
        return $("<a target='_blank'>").attr('href', @homepage).append(
            $("<span class='badge'>").text(@name)
        )

class User
    constructor: (obj) ->
        @name = obj.name
        @id = obj.id

    render: () ->
        return $("<em>").text(@name)




Gitlab.Repository = Repository
Gitlab.User = User
