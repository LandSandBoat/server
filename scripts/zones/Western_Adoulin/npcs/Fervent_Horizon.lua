-----------------------------------
-- Area: Western Adoulin
--  NPC: Fervent Horizon
-- Type: Standard NPC
-- !pos -8 0 -61 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(517)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
