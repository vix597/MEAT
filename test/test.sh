#!/bin/bash

http POST http://localhost:5000/push \
    id=redmine.issue.create \
    author_name="Lloyd Christmas" \
    author_url="https://redmine/users/2" \
    issue_id=1190 \
    issue_url="https://redmine/issues/1190" \
    project_name="Meat" \
    project_url="https://redmine/meat" \
    issue_title="Help help does not work"

sleep 5

http POST http://localhost:5000/push \
    id=redmine.issue.status \
    author_name="Vix597" \
    author_url="https://redmine/users/3" \
    issue_id=1190 \
    issue_url="https://redmine/issues/1190" \
    issue_title="Help help does not work" \
    status="In Progress" \
    project_name="Meat" \
    project_url="https://redmine/meat"


sleep 5


echo '{
    "id": "gitlab.push",
    "user_name": "Vix597",
    "repository": {
        "name": "Meat",
        "homepage": "https://gitlab/meat"
    },
    "ref": "master",
    "commits": [
        1, 2, 3
    ]
}' | http POST http://localhost:5000/push
    


sleep 2




http POST http://localhost:5000/push \
    id=redmine.issue.status \
    author_name="Vix597" \
    author_url="https://redmine/users/3" \
    issue_id=1190 \
    issue_url="https://redmine/issues/1190" \
    issue_title="Help help does not work" \
    project_name="Meat" \
    project_url="https://redmine/meat" \
    status="Resovled"

