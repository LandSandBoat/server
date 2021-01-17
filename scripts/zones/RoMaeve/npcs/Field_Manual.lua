-----------------------------------
-- Field Manual
-- Area: Ro'Maeve
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.regime.bookOnTrigger(player, tpz.regime.type.FIELDS)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.regime.bookOnEventUpdate(player, option, tpz.regime.type.FIELDS)
end

entity.onEventFinish = function(player, csid, option)
    tpz.regime.bookOnEventFinish(player, option, tpz.regime.type.FIELDS)
end

return entity
