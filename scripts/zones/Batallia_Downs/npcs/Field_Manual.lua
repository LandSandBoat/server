-----------------------------------
-- Field Manual
-- Area: Batallia Downs
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.regime.bookOnTrigger(player, xi.regime.type.FIELDS)
end

entity.onEventUpdate = function(player, csid, option)
    xi.regime.bookOnEventUpdate(player, option, xi.regime.type.FIELDS)
end

entity.onEventFinish = function(player, csid, option)
    xi.regime.bookOnEventFinish(player, option, xi.regime.type.FIELDS)
end

return entity
