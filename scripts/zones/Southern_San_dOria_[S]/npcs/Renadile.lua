-----------------------------------
-- Area: Southern San d'Oria [S]
--  NPC: Renadile
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 626)
end

entity.onTrigger = function(player, npc)
    tpz.armorStorage.onTrigger(player, 627)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 627)
end

entity.onEventFinish = function(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 626, 627)
end

return entity
