-----------------------------------
-- Area: King_Ranperre's Tomb
--  NPC: Strange Apparatus
-- !pos -260 7 -142 190
-----------------------------------

function onTrade(player, npc, trade)
    player:startEvent(13, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

function onTrigger(player, npc)
    player:startEvent(11, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
