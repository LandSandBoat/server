-----------------------------------
-- Area: Southern San d'Oria [S]
--  NPC: Renadile
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.armorStorage.onTrade(player, trade, 626)
end

entity.onTrigger = function(player, npc)
    xi.armorStorage.onTrigger(player, 627)
end

entity.onEventUpdate = function(player, csid, option)
    xi.armorStorage.onEventUpdate(player, csid, option, 627)
end

entity.onEventFinish = function(player, csid, option)
    xi.armorStorage.onEventFinish(player, csid, option, 626, 627)
end

return entity
