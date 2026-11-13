# Workflow agents sidebar

Personal clone of Herdr agents 0.1.15, used by main-links.

Priority groups: Needs you, Done, Changes requested, Working, Approved, Waiting on your review,
Waiting on others' review, Blocked on parent branch, Waiting for deployment,
Shipped, Idle. Others' review, parent-branch and Shipped groups start folded. Pinned sessions remain at the top. Wait groups use static icons; hover
one for the reason (for example "#6489 awaits JamesMcDougallJr").

How a group is chosen, first match wins:

1. Runtime blocked/error: Needs you. Runtime working: Working.
2. GitHub, for agents in a realmalliance/realm checkout or rwt worktree whose
   branch has an open, non-draft PR (github.js `prWait`):
   - changes requested: Changes requested (takes precedence over review requests and stacked waits);
   - you are a requested reviewer: Waiting on your review;
   - its base is not master: Blocked on parent branch;
   - approved: Approved (review approval only, not verification of deploy/merge gates);
   - someone else (a person or team) is requested: Waiting on others' review;
   - review required, nobody requested, no human review yet (green mode):
     Waiting on your review.
   Bot reviewers and bot reviews are ignored.
   With no open PR, a PR from that branch merged in the last 14 days: Shipped
   (the newest merge; an open PR on the same branch wins).
3. Terminal label `workflow.deployment=waiting`: Waiting for deployment (also
   takes precedence over Approved). Set with
   `hc label "$HC_TERMINAL_ID" workflow.deployment=waiting` only while waiting;
   clear with `hc label "$HC_TERMINAL_ID" workflow.deployment=` when the wait ends,
   fails or active work resumes.
4. Otherwise the agent's own status (done/idle). Tab titles are plain task
   summaries, never workflow signals -- even when GitHub cannot answer.

GitHub polling: every 150 seconds while the window runs, two paged GraphQL queries
through `gh api graphql` (100 a page, up to 10 pages each, 1 point a page): every
open realm PR, and realm PRs merged in the last 14 days (about 4 pages). The last good answer is kept in this mod's localStorage and used for
15 minutes; after that, GitHub-derived stages fall back to the runtime status (deployment labels still apply). Failures are logged to the
console and keep the last answer. This is presentation only: it never writes to
GitHub, sends terminal input, or runs model calls.

Tests: `node test-github.mjs` (rules) and `herdr-app check .` (mod load).

Restore the stock sidebar by changing the agents block's content.mod in
layouts/main-links.json to agents. Existing sessions are unaffected.
Earlier copies: /tmp/agents-workflow-main.js.pre-github-20261113 and
/tmp/agents-workflow-{main,github}.js.pre-shipped-20261113.
