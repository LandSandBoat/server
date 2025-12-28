-----------------------------------
-- ID: 5564
-- Item: Chunk of Hydra Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- HP 10
-- MP -10
-- Strength +6
-- Intelligence -8
-- Demon Killer 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 10)
    effect:addMod(xi.mod.FOOD_MP, -10)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.INT, -8)
    effect:addMod(xi.mod.DEMON_KILLER, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
