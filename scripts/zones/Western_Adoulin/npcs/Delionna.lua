-----------------------------------
-- Area: Western Adoulin
--  NPC: Delionna
-- Type: Standard NPC
-- !pos 16 0 165 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(561)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
