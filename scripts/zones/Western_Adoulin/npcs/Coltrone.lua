-----------------------------------
-- Area: Western Adoulin
--  NPC: Coltrone
-- Type: Standard NPC
-- !pos -30 19 97 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(555)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
