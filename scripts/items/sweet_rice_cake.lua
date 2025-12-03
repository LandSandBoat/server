-----------------------------------
-- ID: 4270
-- Item: sweet_rice_cake
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP 17
-- Vitality 2
-- Intelligence 3
-- Mind 1
-- HP Recovered While Healing 2
-- MP Recovered While Healing 2
-- Evasion 5
-- Resist Silence 4
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
    effect:addMod(xi.mod.FOOD_MP, 17)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.MND, 1)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.EVA, 5)
    effect:addMod(xi.mod.SILENCERES, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
