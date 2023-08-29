-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (West Tower)
-- !pos -683.709 -6.250 -222.142 33
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
