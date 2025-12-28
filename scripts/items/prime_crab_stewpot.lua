-----------------------------------
-- ID: 5545
-- Item: Prime Crab Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 75
-- MP +15
-- Vitality +1
-- Agility +1
-- Mind +2
-- HP Recovered while healing +7
-- MP Recovered while healing +2
-- Defense 20% Cap 75
-- Evasion +6
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
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 75)
    effect:addMod(xi.mod.FOOD_MP, 15)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.HPHEAL, 7)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.FOOD_DEFP, 20)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 75)
    effect:addMod(xi.mod.EVA, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
