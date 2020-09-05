-----------------------------------
-- Area: Windurst Woods
--  NPC: Istvan
-- Type: ENM Quest Timer
-- !pos 116.294 -6 -98.164 241
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(692)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
