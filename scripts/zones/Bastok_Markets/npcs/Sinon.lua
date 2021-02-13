-----------------------------------
-- Area: Bastok Markets
--  NPC: Sinon
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 395)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 396)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 396)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 395, 396)
end

return entity
