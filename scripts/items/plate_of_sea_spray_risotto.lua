-----------------------------------
-- ID: 4268
-- Item: plate_of_sea_spray_risotto
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 45
-- Dexterity 6
-- Agility 3
-- Mind -4
-- HP Recovered While Healing 1
-- Accuracy % 6 (cap 20)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4268)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.MND, -4)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.FOOD_ACCP, 6)
    target:addMod(xi.mod.FOOD_ACC_CAP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.MND, -4)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.FOOD_ACCP, 6)
    target:delMod(xi.mod.FOOD_ACC_CAP, 20)
end

return itemObject
