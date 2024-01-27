-----------------------------------
-- ID: 4577
-- Item: wild_cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- Aquan killer +12
-- Silence resistance +12
-- MP recovered while healing +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4577)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AQUAN_KILLER, 12)
    target:addMod(xi.mod.SILENCERES, 12)
    target:addMod(xi.mod.MPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AQUAN_KILLER, 12)
    target:delMod(xi.mod.SILENCERES, 12)
    target:delMod(xi.mod.MPHEAL, 5)
end

return itemObject
