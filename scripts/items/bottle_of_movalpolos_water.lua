-----------------------------------
-- ID: 5165
-- Item: Bottle of Movalpolos Water
-- Item Effect: Food Effect with no obvious effects.
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

-- Previously, this item used to give a 2/tick refresh effect (not food effect with refresh) if used on lightsday.
-- That was proven wrong simply by using a movalpolos water on lightsday. It gives a food effect just like JP wiki claims
-- https://wiki.ffo.jp/html/1657.html
itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 30 * 60, 5165)
end

return itemObject
