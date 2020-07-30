-----------------------------------
-- Area: Western Adoulin
--  NPC: Herchambaut
-- Type: Standard NPC
-- !pos 95 0 -47 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(572)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
