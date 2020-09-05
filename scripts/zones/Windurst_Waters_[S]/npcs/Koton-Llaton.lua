-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Koton-Llaton
-- Type: Standard NPC
-- !pos 78.220 -3.75 -173.631 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(402)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
