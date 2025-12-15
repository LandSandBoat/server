-----------------------------------
-- ID: 5619
-- Item: Bowl of Zesti Zoni
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 12
-- MP 12
-- Strength 2
-- Dexterity 2
-- Vitality 2
-- Agility 2
-- Accuracy +2
-- Ranged Accuracy +2
-- Attack +2
-- Ranged Attack +2
-- Evasion +2
-- MP Recovered while healing 1
-- HP Recovered while healing 1
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
    effect:addMod(xi.mod.FOOD_HP, 12)
    effect:addMod(xi.mod.FOOD_MP, 12)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.ACC, 2)
    effect:addMod(xi.mod.RACC, 2)
    effect:addMod(xi.mod.ATT, 2)
    effect:addMod(xi.mod.RATT, 2)
    effect:addMod(xi.mod.EVA, 2)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
