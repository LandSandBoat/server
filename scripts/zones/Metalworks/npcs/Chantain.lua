-----------------------------------
-- Area: Metalworks
--   NPC: Chantain
-- Type: Consulate Representative
-- !pos 21.729 -17 -30.888 237
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(203)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
