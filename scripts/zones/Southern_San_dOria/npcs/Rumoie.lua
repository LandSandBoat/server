-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rumoie
-- Type: Map Marker NPC
-- !pos 149.696 -2.000 151.631 230
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(863)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
