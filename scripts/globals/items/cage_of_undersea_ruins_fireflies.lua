-----------------------------------
-- ID: 5348
-- Alzadaal Fireflies
-- Transports the user to Nyzul Isle Staging Point
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.NYZUL_ISLE then
        return 0
    end
    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.ALZADAAL, 0, 1)
end

item_object.onItemDrop = function(target, item)
   target:addTempItem(xi.items.UNDERSEA_RUINS_FIREFLIES)
end

return item_object
