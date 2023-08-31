-----------------------------------
-- ID: 5193
-- Item: dish_of_spaghetti_nero_di_seppia
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP % 17 (cap 130)
-- Dexterity 3
-- Vitality 2
-- Agility -1
-- Mind -2
-- Charisma -1
-- Double Attack 1
-- Store TP 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5193)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 17)
    target:addMod(xi.mod.FOOD_HP_CAP, 130)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.CHR, -1)
    target:addMod(xi.mod.DOUBLE_ATTACK, 1)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 17)
    target:delMod(xi.mod.FOOD_HP_CAP, 130)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.CHR, -1)
    target:delMod(xi.mod.DOUBLE_ATTACK, 1)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
