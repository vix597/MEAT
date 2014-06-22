import urllib, urllib2

try:
    url_2 = 'http://localhost:5000/meat'
    values = dict(
        id='redmine.issue.create',
        issue_id=1444,
        issue_title='GO FUCK YOUR FACE'
    )
    data = urllib.urlencode(values)
    req = urllib2.Request(url_2, data)
    rsp = urllib2.urlopen(req)
    content = rsp.read()

    # print result
    import re
    pat = re.compile('Title:.*')
    print pat.search(content).group()
except Exception, e:
    print("FUUUUUUUUU: ",str(e))