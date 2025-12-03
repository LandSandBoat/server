-----------------------------------
-- ID: 5615
-- Item: uberkuchen
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 10
-- MP % 3 (cap 15)
-- Intelligence 3
-- HP Recovered While Healing 2
-- MP Recovered While Healing 1
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
    effect:addMod(xi.mod.FOOD_HP, 10)
    effect:addMod(xi.mod.FOOD_MPP, 3)
    effect:addMod(xi.mod.FOOD_MP_CAP, 15)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.INT, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
