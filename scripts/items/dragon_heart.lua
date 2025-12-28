-----------------------------------
-- ID: 4486
-- Item: Dragon Heart
-- Food Effect: 3 Hr, Galka Only
-----------------------------------
-- Strength 7
-- Intelligence -9
-- MP -40
-- HP 40
-- Dragon Killer 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.INT, -9)
    effect:addMod(xi.mod.FOOD_MP, -40)
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.DRAGON_KILLER, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
