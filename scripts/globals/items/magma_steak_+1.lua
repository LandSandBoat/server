-----------------------------------
-- ID: 6072
-- Item: Magma Steak +1
-- Food Effect: 240 Min, All Races
-----------------------------------
-- Strength +9
-- Attack +24% Cap 185
-- Ranged Attack +24% Cap 185
-- Vermin Killer +6
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 6072)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 9)
    target:addMod(xi.mod.FOOD_ATTP, 24)
    target:addMod(xi.mod.FOOD_ATT_CAP, 185)
    target:addMod(xi.mod.FOOD_RATTP, 24)
    target:addMod(xi.mod.FOOD_RATT_CAP, 185)
    target:addMod(xi.mod.VERMIN_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 9)
    target:delMod(xi.mod.FOOD_ATTP, 24)
    target:delMod(xi.mod.FOOD_ATT_CAP, 185)
    target:delMod(xi.mod.FOOD_RATTP, 24)
    target:delMod(xi.mod.FOOD_RATT_CAP, 185)
    target:delMod(xi.mod.VERMIN_KILLER, 6)
end

return itemObject
