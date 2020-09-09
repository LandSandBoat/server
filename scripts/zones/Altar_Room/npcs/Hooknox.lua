-----------------------------------
-- Area: Altar Room
--  NPC: Hooknox
-- Type: Standard NPC
-- !pos -265.248 11.693 -102.547 152
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(46)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
