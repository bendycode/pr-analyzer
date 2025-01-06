# Development Plan

Rough development plan for next steps.

## High level list:
[] make cr weeks:update_stats correctly set prs_first_reviewed correctly
  * so we don't have still follow it up with a full `cr github:fetch_pull_requests FETCH_ALL=true` run
[] overhaul both services and rake tasks to be more efficient
[] get project running in Cursor or VS Code with LLM full context
[] find and fix PRs with negative time to first review
[] resolve the gap between weekly attributes that have different values displayed vs. in the DB
  * Are we calculating in real time, or caching and pulling from the DB?
[] extract logic from services that makes more sense in models
[] get working with Jason Swett's (SaturnCI)[https://app.saturnci.com]
  * This is a favor for Jason, and not a true requirement. We can pause or stop at any time.