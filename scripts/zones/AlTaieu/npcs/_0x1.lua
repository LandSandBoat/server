-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (South Tower)
-- !pos 0 -6.250 -736.912 33
-----------------------------------
local altaieuGlobal = require('scripts/zones/AlTaieu/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    altaieuGlobal.rubiousCrystalOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    altaieuGlobal.rubiousCrystalOnEventFinish(player, csid, option, npc)
end

return entity
