-----------------------------------
-- Area: Port San d'Oria
--   NPC: Eddy
-- Type: NPC Quest Giver
-- !pos -5.209 -8.999 39.833 232
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(723)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
