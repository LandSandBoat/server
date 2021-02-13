-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ratonne
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 510)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 511)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 511)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 510, 511)
end

return entity
