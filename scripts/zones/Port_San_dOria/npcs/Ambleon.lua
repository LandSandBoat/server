-----------------------------------
-- Area: Port San d'Oria
--   NPC: Ambleon
-- Type: NPC World Pass Dealer
-- !pos 71.622 -17 -137.134 232
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(710)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
