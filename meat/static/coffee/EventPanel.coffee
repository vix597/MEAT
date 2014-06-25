


class EventPanel

    constructor: (opts) ->
        @n = 0
        @e = $("<ul class='event-list list-unstyled'>")
        opts.$root.append(@e)
        opts.dispatch.subscribe('redmine', this).subscribe('gitlab', this)
        this.animate = opts.animate || false

    handle: (evt) ->
        cls = ''
        if @n == 0
            @n = 1
            cls = 'even'
        else
            @n = 0
            cls = 'odd'

        $li = $("<li>").addClass(cls).append(
            $("<span class='text-muted datetime monospace'>").text(
                '[' + evt.timestamp.format('HH:mm:ss') + ']'
            )
        ).append(' ')
        evt.render($li)

        @e.prepend($li)
        if @animate
            $li.effect('slide', { direction: 'right' }).effect('pulsate', { duration: 2000, times: 4 })
        else
            $li.show();

Meat.EventPanel = EventPanel
