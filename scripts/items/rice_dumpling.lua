-----------------------------------
-- ID: 4271
-- Item: rice_dumpling
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP 17
-- Strength 3
-- Vitality 2
-- Agility 1
-- Attack 20% (caps @ 45)
-- Ranged Attack 30% (caps @ 45)
-- HP Regeneration While Healing 2
-- MP Regeneration While Healing 2
-- Accuracy 5
-- Resist Paralyze +4
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
    effect:addMod(xi.mod.FOOD_HP, 17)
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 45)
    effect:addMod(xi.mod.FOOD_RATTP, 30)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 45)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.ACC, 5)
    effect:addMod(xi.mod.PARALYZERES, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
