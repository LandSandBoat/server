-----------------------------------
-- ID: 5969
-- Item: Plate of Piscator's Paella
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 45
-- Dexterity 6
-- Accuracy % 16 (cap 85)
-- Undead Killer 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5969)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.FOOD_ACCP, 16)
    target:addMod(xi.mod.FOOD_ACC_CAP, 85)
    target:addMod(xi.mod.UNDEAD_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.FOOD_ACCP, 16)
    target:delMod(xi.mod.FOOD_ACC_CAP, 85)
    target:delMod(xi.mod.UNDEAD_KILLER, 6)
end

return itemObject
