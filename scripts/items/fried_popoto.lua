-----------------------------------
-- ID: 6272
-- Item: fried_popoto
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +30
-- VIT +2
-- Fire resistance +20
-- DEF +20% (cap 145)
-- Subtle Blow +8
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
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.FIRE_MEVA, 20)
    effect:addMod(xi.mod.FOOD_DEFP, 20)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 145)
    effect:addMod(xi.mod.SUBTLE_BLOW, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
