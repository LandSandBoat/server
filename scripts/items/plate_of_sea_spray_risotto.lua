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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 45)
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.MND, -4)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.FOOD_ACCP, 6)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 20)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
