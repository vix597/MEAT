

class @EventRegistry

    constructor: (@opts) ->
        @subscriptions = { children: { }, subs: [ ] }

    subscribe: (id, cb) ->
        parts = id.split('.')
        curr = @subscriptions
        for part in parts
            if part of curr.children
                curr = curr.children[part]
            else
                curr = curr.children[part] = { children: { }, subs: [ ] }
        curr.subs.push(cb)

    fire: (obj) ->
        parts = obj.id.split('.')
        curr = @subscriptions
        for part in parts
            for cb in curr.subs
                cb.handle(obj)

            if part of curr.children
                curr = curr.children[part]
            else
                return




