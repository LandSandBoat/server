-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(132)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 132 and option == 1 then
        player:setPos(-149.900, 0.000, -386.394, 192, xi.zone.CHOCOBO_CIRCUIT)
    end
end

return entity
