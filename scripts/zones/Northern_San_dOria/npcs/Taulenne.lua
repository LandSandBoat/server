-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taulenne
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 772)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 773)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 773)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 772, 773)
end

return entity
