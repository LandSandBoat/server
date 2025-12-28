-----------------------------------
-- ID: 5765
-- Item: red_curry_bun_+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- TODO: Group effects
-- Health 35
-- Strength 7
-- Agility 3
-- Attack % 25 (cap 150)
-- Ranged Atk % 25 (cap 150)
-- Demon Killer 6
-- Resist Sleep +5
-- HP recovered when healing +6
-- MP recovered when healing +3
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
    effect:addMod(xi.mod.FOOD_HP, 35)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 150)
    effect:addMod(xi.mod.FOOD_RATTP, 25)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 150)
    effect:addMod(xi.mod.DEMON_KILLER, 6)
    effect:addMod(xi.mod.SLEEPRES, 5)
    effect:addMod(xi.mod.HPHEAL, 6)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
