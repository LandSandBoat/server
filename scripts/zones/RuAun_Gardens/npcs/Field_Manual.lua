-----------------------------------
-- Field Manual
-- Area: RuAun Gardens
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

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
