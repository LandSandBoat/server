-----------------------------------
-- Area: Port Bastok
--   NPC: Grin
-- Type: Quest Giver
-- !pos -56.533 1.392 -29.432 236
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(295)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
