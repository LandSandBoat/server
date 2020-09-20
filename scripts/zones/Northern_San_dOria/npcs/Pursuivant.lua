-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Pursuivant
-- Type: Standard NPC
-- !pos 54.000 -1.199 11.937 231
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(760)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
