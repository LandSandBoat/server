-----------------------------------
-- Area: South Gustaberg
--  NPC: Field Manual
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.regime.bookOnTrigger(player, xi.regime.type.FIELDS)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.regime.bookOnEventUpdate(player, option, xi.regime.type.FIELDS)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.regime.bookOnEventFinish(player, option, xi.regime.type.FIELDS)
end

return entity
