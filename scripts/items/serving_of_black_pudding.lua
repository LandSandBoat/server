-----------------------------------
-- ID: 5552
-- Item: Serving of Black Pudding
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +5% Cap 25
-- Intelligence +4
-- HP Recovered while healing +1
-- MP Recovered while healing +1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MPP, 5)
    effect:addMod(xi.mod.FOOD_MP_CAP, 25)
    effect:addMod(xi.mod.FOOD_HP, 8)
    effect:addMod(xi.mod.INT, 4)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
