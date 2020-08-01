-----------------------------------
-- Area: Western Adoulin
--  NPC: Fervent Horizon
-- Type: Standard NPC
-- !pos -8 0 -61 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(517)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
