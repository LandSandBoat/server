-----------------------------------
-- ID: 6465
-- Item: behemoth_steak_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +45
-- STR +8
-- DEX +8
-- INT -4
-- Attack +24% (cap 165)
-- Ranged Attack +24% (cap 165)
-- Triple Attack +2%
-- Lizard Killer +5
-- hHP +5
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
    effect:addMod(xi.mod.FOOD_HP, 45)
    effect:addMod(xi.mod.STR, 8)
    effect:addMod(xi.mod.DEX, 8)
    effect:addMod(xi.mod.INT, -4)
    effect:addMod(xi.mod.FOOD_ATTP, 24)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 165)
    effect:addMod(xi.mod.FOOD_RATTP, 24)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 165)
    effect:addMod(xi.mod.TRIPLE_ATTACK, 2)
    effect:addMod(xi.mod.LIZARD_KILLER, 5)
    effect:addMod(xi.mod.HPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
