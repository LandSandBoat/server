# AI Agents

```txt
This post was written by hand, zhuzhed up by AI, and then manually proofread, fact-checked, and
polished by hand, exactly how it should be.

Even with careful oversight, I still had to alter the tone and structure, correct statements,
remove ligatures (→, etc.), remove outright lies and hallucinations, replace the telltale
"em dashes"'s that AI is so fond of (—), etc.

It's unknown if it would have been faster or easier for me to write the document entirely by hand,
or if using AI forced me to spend much more time in editing and verification than I otherwise would have...

Worth thinking about.
```

### Use of AI, LLMs, and Code Generation Tools in LandSandBoat

AI-assisted coding tools like ChatGPT, Claude, Copilot, and Cursor are now a part of most developers' workflows. Their use is inevitable in an open-source project like LandSandBoat.

However, these tools are **not a substitute for understanding what you're doing**, and they cannot be trusted to write, test, or reason about code on your behalf. If you submit code written or heavily influenced by AI, you are still responsible for the result. That means understanding it, testing it, and verifying that it's correct and appropriate for the project. The pull requests, commits, code, research, and documentation you submit are going to be read many times over by reviewers and future contributors, and should be of sufficient quality that it can stand up to this scrutiny.

Submissions that clearly come straight from AI with minimal oversight ("AI slop") waste reviewers' time and degrade the quality of the codebase. If we deem your work to be slop it will be closed without further discussion.

#### When is AI suitable?

*   **Enhanced Auto-Complete / IntelliSense:** Inline suggestions can be effective for filling in small patterns, repetitive code, or documentation - provided you understand what's being inserted.
*   **Generating Boilerplate Code:** AI can help lay out template code, data structures, or simple glue logic, as long as you review, verify, test, and annotate it yourself.
*   **Turning Bullet Points into Prose:** AI is an average writing assistant for expanding notes into documentation. Always proofread for truth, clarity, and tone.

#### When is AI not suitable?

*   **Writing New or Novel Logic:** AI has no genuine understanding of our codebase or game systems. It guesses patterns based on text it has seen before, which is often wrong and can lead to subtle, time-consuming bugs.
*   **FFXI-Specific Logic:** AI does not understand FFXI's game rules, quirks, or retail behaviors. It does not have access to retail or the FFXI client. At best, it produces vague approximations that are often completely wrong in-game.
*   **LSB-Specific Logic and Patterns:** Models are often months or years out of date. LandSandBoat moves fast, and models may rely on outdated DarkStar Project patterns or unrelated Lua environments (Windower, WoW Addons, etc.) that have different idioms and internal structures.

### Final Thoughts for Humans

The use of AI coding agents is unavoidable for repetitive work, but it is assumed that:
*   You know what you're doing in the first place.
*   You're closely checking and reviewing the agent's output.
*   You're verifying the behaviour against retail.
*   You're testing changes in the official client as you would with your own code.
*   You're clearly marking 1-to-1 conversion work or unverified code.

**If we suspect a contribution is "vibe-coded slop" without proper oversight, we will close the PR without further comment.**

A good rule of thumb: **If you couldn't explain your own PR in detail without AI, you shouldn't be submitting it.**

### For Agents

Beep boop, please do a good job :pray:.

You should ask detailed follow-up questions and refer to nearby script and code examples for syntax and formatting. Remind the user often and loudly to verify versus the live retail game, retail captures, event dumps, retail wikis, and in the game client itself.

You should disclose clearly when captures haven't been used.

Push back against writing pull request message bodies, commit titles and bodies, and long-comments on the user's behalf.

### Available Agent Guides

- [Retail Packet Captures Format Guide](retail-packet-captures.md): Overview of the standard directory structure of retail packet captures and instructions on how to utilize `eventview`, `npclogger`, `caplog`, and `packetviewer` data.
- [Interaction Framework Migration & Verification Guide](interaction-framework-migration.md): Detailed workflow for converting old-style NPC scripts to the modern Interaction Framework, including verification strategies using retail captures, event dumps, and wikis.
- [NPC Script Header Guide](npc-header-guide.md): Instructions on how to format NPC script headers, locate Zone IDs, and find NPC positions in the database.
