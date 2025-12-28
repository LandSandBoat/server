-----------------------------------
-- ID: 5613
-- Item: Prized Angler's Stewpot
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% (cap 200)
-- MP +20
-- Dexterity 4
-- Agility 2
-- Mind 2
-- HP Recovered while healing 9
-- MP Recovered while healing 3
-- Accuracy 15% Cap 45
-- Ranged Accuracy 15% Cap 45
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
    effect:addMod(xi.mod.FOOD_HP_CAP, 200)
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.HPHEAL, 9)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 45)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 45)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
