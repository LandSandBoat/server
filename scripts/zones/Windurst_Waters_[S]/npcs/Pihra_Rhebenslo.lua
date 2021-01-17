-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Pihra_Rhebenslo
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 442)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 443)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 443)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 442, 443)
end

return entity
