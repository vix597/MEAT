

class @EventDispatch

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
        return this

    fire: (obj) ->
        obj.timestamp = moment.utc(obj.timestamp).local()
        parts = obj.id.split('.')
        curr = @subscriptions
        for part in parts
            for cb in curr.subs
                cb.handle(obj)

            if part of curr.children
                curr = curr.children[part]
            else
                return



if typeof String.prototype.startsWith != 'function'
    String.prototype.startsWith = (str) ->
        return this.slice(0, str.length) == str;
