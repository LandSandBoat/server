-----------------------------------
-- ID: 10596
-- Decennial Hose +1
-- Enchantment: Invisible, Sneak, and Deodorize effects 5m fixed duration
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.SNEAK, xi.effect.SNEAK, 1, 10, 300)
    target:addStatusEffectEx(xi.effect.INVISIBLE, xi.effect.INVISIBLE, 1, 10, 300)
    target:addStatusEffectEx(xi.effect.DEODORIZE, xi.effect.DEODORIZE, 1, 10, 300)
end

return itemObject
