-----------------------------------
-- ID: 6464
-- Item: behemoth_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +40
-- STR +7
-- DEX +7
-- INT -3
-- Attack +23% (cap 160)
-- Ranged Attack +23% (cap 160)
-- Triple Attack +1%
-- Lizard Killer +4
-- hHP +4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.DEX, 7)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.FOOD_ATTP, 23)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 160)
    effect:addMod(xi.mod.FOOD_RATTP, 23)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 160)
    effect:addMod(xi.mod.TRIPLE_ATTACK, 1)
    effect:addMod(xi.mod.LIZARD_KILLER, 4)
    effect:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
