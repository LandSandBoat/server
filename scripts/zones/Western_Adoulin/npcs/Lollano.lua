-----------------------------------
-- Area: Western Adoulin
--  NPC: Lollano
-- Type: Standard NPC
-- !pos 96 0 -13 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(516)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
