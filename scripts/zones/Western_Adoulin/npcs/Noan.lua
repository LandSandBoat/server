-----------------------------------
-- Area: Western Adoulin
--  NPC: Noan
-- Type: Standard NPC
-- !pos 23 0 -84 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(544)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
