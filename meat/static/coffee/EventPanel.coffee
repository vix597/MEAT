


class @EventPanel

    constructor: (@opts) ->
        @n = 0
        @e = $("<ul class='event-list list-unstyled'>")
        @opts.$root.append(@e)

    add: ($item, obj, animate) ->
        cls = ''
        if @n == 0
            @n = 1
            cls = 'even'
        else
            @n = 0
            cls = 'odd'

        $item = $("<li>").addClass(cls).append(
            $("<span class='text-muted datetime'>").text(obj.timestamp)
        ).append(' ').append($item).hide()
        
        @e.prepend($item)

        if animate
            $item.effect('slide', { direction: 'right' }).effect('pulsate', { duration: 2000, times: 4 })
        else
            $item.show();

