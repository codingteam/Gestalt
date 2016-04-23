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

%% this record directly corresponds to the body of 200 "News" response:
%% https://github.com/codingteam/Gestalt/wiki/Public-API#responses
-record(news_item,
    {
        subject = ""
    ,   action = ""
    ,   issue_url = ""
    ,   issue_title = ""
    ,   pull_request_url = ""
    ,   pull_request_title = ""
    ,   user = ""
    ,   user_url = ""
    ,   repo = ""
    ,   repo_url = ""
    ,   branch = ""
    ,   commits_count = 0
    ,   assignee = ""
    ,   assignee_url = ""
    ,   label = ""
    ,   status = ""
    ,   merged = false
    ,   datetime = os:timestamp()
    }).

-record(news,
    {
        news_items = [] %% list of `news_item`s
    }).

-record(update_activity,
    { repo
    , repo_url
    , user
    , user_url
    , commits_count
    }).

-record(repo_activity_item,
    {
        name = ""
    ,   url = ""
    ,   day_average = 0
    ,   week_average = 0
    ,   month_average = 0
    }).

-record(user_activity_item,
    {
        name = ""
    ,   url = ""
    ,   day_average = 0
    ,   week_average = 0
    ,   month_average = 0
    }).

%% this record directly corresponds to the body of 200 "Activity" response:
%% https://github.com/codingteam/Gestalt/wiki/Public-API#responses-1
-record(activity,
    {
        repos = [
            %% `repo_activity_item`s go here
        ]
    ,   users = [
            %% `user_activity_item`s go here
        ]
    }).

-record(update_analytics,
    { user
    , user_url
    , language
    , action % "added" or "removed"
    }).

%% this record directly corresponds to the body of 200 "Analytics" response:
%% https://github.com/codingteam/Gestalt/wiki/Public-API#responses-2
-record(analytics_item,
    {
        user = ""
    ,   user_url = ""
        %% keys are strings (the names of the languages), values are integers
        %% (number of repos)
    ,   repos_per_language = maps:new()
    }).

-record(analytics,
    {
        analytics_items = [] %% list of `analytics_item`s
    }).
