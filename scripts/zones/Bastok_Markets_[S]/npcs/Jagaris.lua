-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Jagaris
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 328)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 329)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 329)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 328, 329)
end

return entity
