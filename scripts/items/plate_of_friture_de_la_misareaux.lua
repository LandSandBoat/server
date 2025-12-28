-----------------------------------
-- ID: 5159
-- Item: plate_of_friture_de_la_misareaux
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity 3
-- Vitality 3
-- Mind -3
-- Defense 5
-- Ranged ATT % 7
-- Ranged ATT Cap 15
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
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.DEF, 5)
    effect:addMod(xi.mod.FOOD_RATTP, 7)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
