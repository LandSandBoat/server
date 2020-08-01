-----------------------------------
-- Area: FeiYin
--  NPC: Strange Apparatus
-- !pos -94 -15 220 204
-----------------------------------

function onTrade(player, npc, trade)
    player:startEvent(27, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

function onTrigger(player, npc)
    player:startEvent(25, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
