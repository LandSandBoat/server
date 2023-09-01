-----------------------------------
-- ID: 4334
-- Item: ear_of_grilled_corn
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 10
-- Vitality 4
-- Health Regen While Healing 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4334)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.HPHEAL, 1)
end

return itemObject
