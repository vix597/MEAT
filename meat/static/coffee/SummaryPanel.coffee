

class SummaryPanel
    constructor: (attrs) ->
        @e = $("<div>")
        attrs.$root.append(@e)
        @index = -1
        @prev = -1
        @panels = [ ]
        @divs = [ ]

        self = this
        @interval = setInterval(
            () ->
                self.changePanel()
            , 5000
        )

    addPanel: (panel) ->
        @panels.push(panel)
        @divs.push($("<div>").hide().appendTo(@e))

    changePanel: () ->
        if @panels.length == 0
            return null

        orig = @index
        @index = if (@index+1) == @panels.length then 0 else (@index+1)
        if @prev >= 0
            @divs[@prev].hide()

        @prev = orig
        @panels[@index].onDisplay(@divs[@index].show())

Meat.SummaryPanel = SummaryPanel