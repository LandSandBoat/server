-----------------------------------
-- Area: Western Adoulin
--  NPC: Mosil-Nosil
-- Type: Standard NPC
-- !pos -45 0 -29 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(513)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
