-----------------------------------
-- ID: 6468
-- Item: plate_of_sublime_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +40
-- MP +20
-- STR +6
-- DEX +7
-- MND -3
-- CHR +6
-- Accuracy +10% (cap 100)
-- Ranged Accuracy +10% (cap 100)
-- Resist Sleep +1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.DEX, 7)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.CHR, 6)
    effect:addMod(xi.mod.FOOD_ACCP, 10)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 100)
    effect:addMod(xi.mod.FOOD_RACCP, 10)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 100)
    effect:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
