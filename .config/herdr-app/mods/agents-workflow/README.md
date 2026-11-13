# Workflow agents sidebar

Personal clone of Herdr agents 0.1.15, used by main-links.

Priority groups: Needs you, Done, Working, Waiting on your review,
Waiting on others' review, Blocked on parent branch, Waiting for deployment,
Idle. Pinned sessions remain at the top.
Review, stacked-parent and deployment waits use static icons; normal work keeps its spinner.

The live tab title is the workflow signal: 👀 means waiting on Eugene's review;
✋ means waiting on someone else's review; 📚 means blocked on a stacked parent
branch; 🕒 means waiting for deployment. 🚀 means active shipping, not necessarily
waiting. Change back to 🔨, 🧪 or 🚀 when work resumes, and 🚢 when shipped.
A runtime blocked/error state always stays under Needs you, even if the
workflow marker is stale. Unknown titles retain Herdr's normal status.

No background shell commands, network polling, model calls or terminal input.
This changes presentation only. Titles must be kept accurate by the agents.
The elapsed time reflects time in the displayed category, not token usage.

Restore the stock sidebar by changing the agents block's content.mod in
layouts/main-links.json to agents. Existing sessions are unaffected.
