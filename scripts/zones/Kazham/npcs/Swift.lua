-----------------------------------
-- Area: Kazham
--   NPC: Swift
-- Type: Standard NPC
-- !pos 2.017 -5 -1.880 250
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10018)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
