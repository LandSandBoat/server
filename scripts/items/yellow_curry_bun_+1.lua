-----------------------------------
-- ID: 5763
-- Item: yellow_curry_bun_+1
-- Food Effect: 60 min, All Races
-----------------------------------
-- TODO: Group effects
-- Health Points 30
-- Strength 5
-- Vitality 2
-- Agility 3
-- Intelligence -2
-- Attack 22% (caps @ 85)
-- Ranged Attack 22% (caps @ 85)
-- Resist Sleep +5
-- Resist Stun +6
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
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 85)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 85)
    effect:addMod(xi.mod.SLEEPRES, 5)
    effect:addMod(xi.mod.STUNRES, 6)
    effect:addMod(xi.mod.HPHEAL, 6)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
