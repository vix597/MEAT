
@Redmine = { }
@Gitlab = { }
@Meat = { }

class EventDispatch

    constructor: (@opts) ->
        @subscriptions = { children: { }, subs: [ ] }
        @factories = { }

    createEvent: (ns, obj) ->
        if ns of @factories
            return @factories[ns].create(obj) || obj
        return obj

    register: (ns, factory) ->
        @factories[ns] = factory

    subscribe: (id, cb) ->
        parts = id.split('.')
        curr = @subscriptions
        for part in parts
            if part of curr.children
                curr = curr.children[part]
            else
                curr = curr.children[part] = { children: { }, subs: [ ] }
        curr.subs.push(cb)
        return this

    fire: (obj) ->
        obj.timestamp = moment.utc(obj.timestamp).local()
        parts = obj.id.split('.')

        evt = @createEvent(parts[0], obj)

        if not (parts[0] of @subscriptions.children)
            return

        #curr = @subscriptions.children[parts[0]]
        curr = @subscriptions
        for part in parts
            for cb in curr.subs
                cb.handle(evt)

            if part of curr.children
                curr = curr.children[part]
            else
                return

        for cb in curr.subs
            cb.handle(evt)

Meat.EventDispatch = EventDispatch


if typeof String.prototype.startsWith != 'function'
    String.prototype.startsWith = (str) ->
        return this.slice(0, str.length) == str;
