-----------------------------------
-- ID: 5164
-- Item: jar_of_ground_wasabi
-- Food Effect: 5Min, All Races
-----------------------------------
-- Strength -1
-- Dexterity -1
-- Agility -1
-- Vitality -1
-- Intelligence -1
-- Mind -1
-- Charisma -1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5164)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.CHR, -1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.CHR, -1)
end

return itemObject
