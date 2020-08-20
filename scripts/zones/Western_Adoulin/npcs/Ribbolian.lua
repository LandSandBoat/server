-----------------------------------
-- Area: Western Adoulin
--  NPC: Ribbolian
-- Type: Standard NPC
-- !pos 21 1 -27 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(518)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
