-----------------------------------
-- Area: Western Adoulin
--  NPC: Katya
-- Type: Standard NPC
-- !pos 11 0 68 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(559)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
