-----------------------------------
-- ID: 5582
-- Item: plate_of_patlican_salata
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility 4
-- Vitality -1
-- Evasion +6
-- hHP +2
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
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.EVA, 6)
    effect:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
