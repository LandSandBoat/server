-----------------------------------
-- ID: 5549
-- Item: Prized Angler's Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 100
-- MP +20
-- Strength +4
-- Agility +2
-- Mind +2
-- HP Recovered while healing +9
-- MP Recovered while healing +3
-- Attack 18% Cap 80
-- Evasion +7
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 100)
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.HPHEAL, 9)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
    effect:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
