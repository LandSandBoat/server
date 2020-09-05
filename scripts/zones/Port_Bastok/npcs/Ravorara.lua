-----------------------------------
-- Area: Port Bastok
--   NPC: Ravorara
-- Type: Quest Giver
-- !pos -151.062 -7 -7.243 236
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(310)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
