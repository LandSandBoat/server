-----------------------------------
-- Area: Beaucedine Glacier (S)
--   NPC: Watchful Pixie
-- Type: Quest NPC
-- !pos -56.000 -1.3 -392.000 136
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(4002)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
