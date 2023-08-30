-----------------------------------
-- ID: 4510
-- Item: Acorn Cookie
-- Food Effect: 3Min, All Races
-----------------------------------
-- Aquan killer +10
-- Silence resistance +10
-- MP recovered while healing +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4510)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AQUAN_KILLER, 10)
    target:addMod(xi.mod.SILENCERES, 10)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AQUAN_KILLER, 10)
    target:delMod(xi.mod.SILENCERES, 10)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
