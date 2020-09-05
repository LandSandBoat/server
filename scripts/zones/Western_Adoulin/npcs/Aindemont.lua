-----------------------------------
-- Area: Western Adoulin
--  NPC: Aindemont
-- Type: Standard NPC
-- !pos 171 4 -33 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(569)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
