

class ProjectStatusPanel
    constructor: (attrs) ->
        @projects = [ ]
        @index = -1
        @prev = false
        attrs.dispatch.subscribe("redmine.project.status", this)

    updateProject: (proj) ->
        found = -1
        index = 0
        for p in @projects
            if p.project.identifier == proj.project.identifier
                found = index
                break
            index += 1

        if found >= 0
            @projects[index] = proj
        else
            @projects.push(proj)

    handle: (obj) ->
        @updateProject(obj)

    onDisplay: ($root) ->
        if @projects.length == 0
            return false

        if @projects.length == 1 and @prev
            return true

        @index = if (@index+1) == @projects.length then 0 else (@index+1)
        @prev = true
        $root.empty().append(@render())
        return true

    render: () ->
        curr = @projects[@index]

        $cats = $("<table class='table table-condensed'>")
        for cat in curr.issues.categories
            $cats.append(
                $("<tr>").append(
                    $("<th>").text(cat.name+': ')
                ).append(
                    $("<td>").append(
                        $("<span class='badge alert-danger'>").text(cat.trackers.Bug)
                    ).append(' / ').append(
                        $("<span class='badge alert-info'>").text(cat.trackers.Feature)
                    )
                )
            )

        $root = $("<div class='col-md-12'>").append(
            $("<h1 class='status-title'>").text(curr.project.name + ' ').append(
                $("<small><span class='label label-primary'>Redmine</span></small>")
            )
        ).append(
            $("<div class='row'>").append(
                $("<div class='col-md-3'>").append(
                    $("<div class='panel panel-default status-panel'>").append(
                        $("<div class='panel-heading'>").append(
                            $("<div class='panel-title'>Open Issues</div>")
                        )
                    ).append(
                        $("<div class='panel-body status-summary'>").text(curr.issues.open)
                    )
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='panel panel-danger status-panel'>").append(
                        $("<div class='panel-heading'>").append(
                            $("<div class='panel-title'>Bugs</div>")
                        )
                    ).append(
                        $("<div class='panel-body status-summary text-danger'>").text(curr.issues.trackers.Bug)
                    )
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='panel panel-info status-panel'>").append(
                        $("<div class='panel-heading'>").append(
                            $("<div class='panel-title'>Features</div>")
                        )
                    ).append(
                        $("<div class='panel-body status-summary text-info'>").text(curr.issues.trackers.Feature)
                    )
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='panel panel-default status-panel'>").append(
                        $("<div class='panel-heading'>").append(
                            $("<div class='panel-title'>Categories</div>")
                        )
                    ).append(
                        $cats
                    )
                )
            )
        )
        return $root

        ###
        $root = $("<div class='col-md-12'>").append(
            $("<div class='row'>").append(
                $("<h1>").text(curr.project.name+' ').append(
                    $("<small>").append(
                        $("<span class='label label-primary'>Redmine</span>")
                    )
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='well well-sm'>").append(
                        $("<h3>Open Issues</h3>")
                    ).append(
                        $("<div>").text(curr.issues.open)
                    ).append($("<div>&nbsp;</div>"))
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='well well-sm'>").append(
                        $("<h3>Bugs</h3>")
                    ).append(
                        $("<div>").text(curr.issues.trackers.Bug)
                    ).append($("<div>&nbsp;</div>"))
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='well well-sm'>").append(
                        $("<h3>Features</h3>")
                    ).append(
                        $("<div>").text(curr.issues.trackers.Feature)
                    ).append($("<div>&nbsp;</div>"))
                )
            ).append(
                $("<div class='col-md-3'>").append(
                    $("<div class='well well-sm'>").append(
                        $("<h3>Support</h3>")
                    ).append(
                        $("<div>").text(curr.issues.trackers.Support)
                    ).append($("<div>&nbsp;</div>"))
                )
            )
        )

        if curr.versions.length
            $root.append(
                $("<div class='row'>").append(
                    $("<div class='col-md-3'>").append(
                        $("<div class='well well-sm'>").append(
                            $("<h3>Active Versions</h3>")
                        ).append(
                            $("<div>").text(curr.versions.length)
                        ).append($("<div>&nbsp;</div>"))
                    )
                ).append(
                    $("<div class='col-md-3'>").append(
                        $("<div class='well well-sm'>").append(
                            $("<h3>Next Version</h3>")
                        ).append(
                            $("<div>").text(curr.versions[0].name)
                        ).append(
                            $("<div>").text(
                                curr.versions[0].due.format("MM/DD/YYYY HH:mm")
                            )
                        )
                    )
                )
            )
        ###
        return $root

Redmine.ProjectStatusPanel = ProjectStatusPanel