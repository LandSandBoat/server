-----------------------------------
-- ID: 4550
-- Item: plate_of_bream_risotto
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 40
-- Dexterity 6
-- Agility 3
-- Mind -4
-- Health Regen While Healing 1
-- Ranged Accuracy % 6
-- Ranged Accuracy Cap 15
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4550)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.MND, -4)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.FOOD_RACCP, 6)
    target:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.MND, -4)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.FOOD_RACCP, 6)
    target:delMod(xi.mod.FOOD_RACC_CAP, 15)
end

return itemObject
