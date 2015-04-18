-record(get_news_args,
    { since = 0
    , until = infinity
    }).

-record(append_to_news_args,
    { subject
    , action
    , issue_url
    , issue_title
    , pull_request_url
    , pull_request_title
    , repo
    , repo_url
    , user
    , user_url
    , assignee
    , assignee_url
    , label
    , status
    , merged
    , branch
    , commits_count
    , datetime
    }).

-record(update_activity,
    { repo
    , repo_url
    , user
    , user_url
    , commits_count
    }).

-record(update_analytics,
    { user
    , user_url
    , language
    , action % "added" or "removed"
    }).
