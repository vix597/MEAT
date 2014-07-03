#!/bin/bash


echo '{
    "id": "redmine.project.status",
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "issues": {
        "open": 128,
        "trackers": {
            "Bug": 64,
            "Feature": 60,
            "Support": 4
        },
        "categories": [
            {
                "name": "API",
                "trackers": {
                    "Bug": 10,
                    "Feature": 5
                }
            }
        ]
    },
    "versions": [
        {
            "name": "1.0",
            "due": 1404432000000
        }
    ]
}' | http POST http://localhost:5000/push

echo '{
    "id": "redmine.project.status",
    "project": {
        "name": "Rare",
        "identifier": "rare",
        "url": "https://redmine/rare"
    },
    "issues": {
        "open": 391,
        "trackers": {
            "Bug": 21,
            "Feature": 370,
            "Support": 0
        },
        "categories": [
            {
                "name": "Docs",
                "trackers": {
                    "Bug": 0,
                    "Feature": 5
                }
            },
            {
                "name": "UI",
                "trackers": {
                    "Bug": 23,
                    "Feature": 51
                }
            },
            {
                "name": "Logging",
                "trackers": {
                    "Bug": 1,
                    "Feature": 2
                }
            }
        ]
    },
    "versions": [ ]
}' | http POST http://localhost:5000/push

sleep 2

echo '{
    "id": "redmine.issue.create",
    "author": {
        "name": "SailorMoon69",
        "url": "https://redmine/users/3"
    },
    "issue": {
        "id": 3,
        "url": "https://redmine/issues/3",
        "title": "Help help does not work"
    },
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "tracker": "Bug"
}' | http POST http://localhost:5000/push

sleep 2

echo '{
    "id": "redmine.issue.status",
    "assigned_to": {
        "name": "SailorMoon69",
        "url": "https://redmine/users/4"
    },
    "issue": {
        "id": 3,
        "url": "https://redmine/issues/3",
        "title": "Help help does not work"
    },
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "author": {
        "name": "SailorMoon69",
        "url": "https://redmine/users/4"
    },
    "status": "In Progress",
    "tracker": "Bug"
}' | http POST http://localhost:5000/push


sleep 5

echo '{
    "id": "redmine.issue.comment",
    "author": {
        "name": "Vix597",
        "url": "https://redmine/users/4"
    },
    "issue": {
        "id": 3,
        "url": "https://redmine/issues/3",
        "title": "Help help does not work"
    },
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "tracker": "Bug"
}' | http POST http://localhost:5000/push

sleep 5

echo '{
 "before": "95790bf891e76fee5e1747ab589903a6a1f80f22",
 "after": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
 "ref": "refs/heads/master",
 "user_id": 4,
 "user_name": "SailorMoon69",
 "repository": {
   "name": "MEAT",
   "url": "git@gitlab:meat.git",
   "description": "",
   "homepage": "http://gitlab/MEAT"
 },
 "commits": [
   {
     "id": "b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327",
     "message": "Update Catalan translation to e38cb41.",
     "timestamp": "2011-12-12T14:27:31+02:00",
     "url": "http://localhost/diaspora/commits/b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327",
     "author": {
       "name": "Jordi Mallach",
       "email": "jordi@softcatala.org"
     }
   },
   {
     "id": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
     "message": "fixed readme",
     "timestamp": "2012-01-03T23:36:29+02:00",
     "url": "http://localhost/diaspora/commits/da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
     "author": {
       "name": "GitLab dev user",
       "email": "gitlabdev@dv6700.(none)"
     }
   }
 ],
 "total_commits_count": 2
}' | http POST http://localhost:5000/push.gitlab

sleep 5

echo '{
    "id": "redmine.issue.status",
    "author": {
        "name": "SailorMoon69",
        "url": "https://redmine/users/3"
    },
    "issue": {
        "id": 3,
        "url": "https://redmine/issues/3",
        "title": "Help help does not work"
    },
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "tracker": "Bug",
    "status": "Resolved"
}' | http POST http://localhost:5000/push

sleep 2

echo '{
    "id": "redmine.issue.status",
    "author": {
        "name": "Vix597",
        "url": "https://redmine/users/4"
    },
    "issue": {
        "id": 3,
        "url": "https://redmine/issues/3",
        "title": "Help help does not work"
    },
    "project": {
        "name": "MEAT",
        "identifier": "meat",
        "url": "https://redmine/meat"
    },
    "tracker": "Bug",
    "status": "Closed"
}' | http POST http://localhost:5000/push
