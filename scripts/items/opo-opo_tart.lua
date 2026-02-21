-----------------------------------
-- ID: 4287
-- Item: opo-opo_tart
-- Food Effect: 1hour, All Races
-----------------------------------
-- HP 12
-- MP 12
-- Intelligence 4
-- MP Recovered While Healing 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 3600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 12)
    effect:addMod(xi.mod.FOOD_MP, 12)
    effect:addMod(xi.mod.INT, 4)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
