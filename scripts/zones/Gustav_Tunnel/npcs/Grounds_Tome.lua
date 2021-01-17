-----------------------------------
-- Area: Gustav Tunnel
--  NPC: Grounds Tome
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.regime.bookOnTrigger(player, tpz.regime.type.GROUNDS)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.regime.bookOnEventUpdate(player, option, tpz.regime.type.GROUNDS)
end

entity.onEventFinish = function(player, csid, option)
    tpz.regime.bookOnEventFinish(player, option, tpz.regime.type.GROUNDS)
end

return entity
