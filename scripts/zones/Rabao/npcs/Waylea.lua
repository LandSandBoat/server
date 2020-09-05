-----------------------------------
-- Area: Rabao
--   NPC: Waylea
-- Type: Reputation
-- !pos 12.384 4.658 -32.392 247
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:startEvent(57 + (player:getFameLevel(4) - 1))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
