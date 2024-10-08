-----------------------------------
-- Area: Port San d'Oria
--  NPC: Door: Arrivals Entrance
-- !pos -24 -8 15 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 12 then
        player:startEvent(518)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
