-----------------------------------
-- Area: Port Jeuno
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(319)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 319 and option == 1 then
        player:setPos(-339.852, 0.000, -308.471, 192, xi.zone.CHOCOBO_CIRCUIT)
    end
end

return entity
