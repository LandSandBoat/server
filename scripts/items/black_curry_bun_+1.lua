-----------------------------------
-- ID: 5764
-- Item: black_curry_bun+1
-- Food Effect: 60 min, All Races
-----------------------------------
-- TODO: Group effects
-- Dexterity +4
-- Vitality +6
-- Intelligence +3
-- Mind +1
-- Accuracy +7
-- Ranged Accuracy +7
-- Evasion +7
-- Defense +25% (cap 200)
-- Resist Sleep +5
-- hHP +6
-- hMP +3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.VIT, 6)
    effect:addMod(xi.mod.INT, 3)
    effect:addMod(xi.mod.MND, 1)
    effect:addMod(xi.mod.ACC, 7)
    effect:addMod(xi.mod.RACC, 7)
    effect:addMod(xi.mod.EVA, 7)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 200)
    effect:addMod(xi.mod.SLEEPRES, 5)
    effect:addMod(xi.mod.HPHEAL, 6)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
