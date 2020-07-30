-----------------------------------
-- Area: Port Bastok
--   NPC: Synergy Engineer
-- Type: Standard NPC
-- !pos 37.700 -0.3 -50.500 236
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
