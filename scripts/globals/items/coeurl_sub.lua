-----------------------------------
-- ID: 5166
-- Item: coeurl_sub
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 10
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Health Regen While Healing 1
-- Attack % 20
-- Attack Cap 75
-- Ranged ATT % 20
-- Ranged ATT Cap 75
-- Resist Stun +4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5166)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 75)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 75)
    target:addMod(xi.mod.STUNRES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 75)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 75)
    target:delMod(xi.mod.STUNRES, 4)
end

return itemObject
