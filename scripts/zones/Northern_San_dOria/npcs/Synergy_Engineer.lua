-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Synergy Engineer
-- Type: Standard NPC
-- !pos -123.000 10.5 244.000 231
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(11002)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
