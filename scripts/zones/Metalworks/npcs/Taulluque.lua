-----------------------------------
-- Area: Metalworks
--   NPC: Taulluque
-- Type: Past Event Watcher
-- !pos 39.907 -14.999 -21.083 237
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(771)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
