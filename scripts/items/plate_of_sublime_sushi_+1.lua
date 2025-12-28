-----------------------------------
-- ID: 6469
-- Item: plate_of_sublime_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +45
-- MP +25
-- STR +7
-- DEX +8
-- MND -4
-- CHR +7
-- Accuracy +11% (cap 105)
-- Ranged Accuracy +11% (cap 105)
-- Resist Sleep +2
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 45)
    effect:addMod(xi.mod.FOOD_MP, 25)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.DEX, 8)
    effect:addMod(xi.mod.MND, -4)
    effect:addMod(xi.mod.CHR, 7)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 105)
    effect:addMod(xi.mod.FOOD_RACCP, 11)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 105)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
