-----------------------------------
-- Area: Western Adoulin
--  NPC: Illi-Milli
-- Type: Standard NPC
-- !pos 170 4 -5 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(568)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
