-----------------------------------
-- ID: 5577
-- Item: Bowl of Sutlac
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +10
-- INT +1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 10800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 8)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.INT, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
