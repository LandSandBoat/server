-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Jagaris
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 328)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 329)
end

entity.onEventUpdate = function(player, csid, option)
    xi.armorStorage.onEventUpdate(player, csid, option, 329)
end

entity.onEventFinish = function(player, csid, option)
    xi.armorStorage.onEventFinish(player, csid, option, 328, 329)
end

return entity
