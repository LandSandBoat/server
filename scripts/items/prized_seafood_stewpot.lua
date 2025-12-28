-----------------------------------
-- ID: 5240
-- Item: Prized Seafood Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% Cap 100
-- MP +20
-- Dexterity 2
-- Vitality 2
-- Agility 2
-- Mind 2
-- HP Recovered while healing 9
-- MP Recovered while healing 3
-- Accuracy 7
-- Ranged Accuracy 7
-- Evasion 7
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
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.HPHEAL, 9)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.ACC, 7)
    effect:addMod(xi.mod.RACC, 7)
    effect:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
