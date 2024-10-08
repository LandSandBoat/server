-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pulloie
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getNation() == 0 then
        player:startEvent(595)
    else
        player:startEvent(598)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
