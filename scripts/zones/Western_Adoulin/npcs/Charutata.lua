-----------------------------------
-- Area: Western Adoulin
--  NPC: Charutata
-- Type: Standard NPC
-- !pos -17 0 -90 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(536)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
