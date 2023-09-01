-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (East Tower)
-- !pos 683.718 -6.250 -222.167 33
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
