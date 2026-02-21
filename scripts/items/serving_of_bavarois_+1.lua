-----------------------------------
-- ID: 5730
-- Item: Serving of Bavarois +1
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 25
-- Intelligence 4
-- hHP +4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 14400, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 25)
    effect:addMod(xi.mod.INT, 4)
    effect:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
