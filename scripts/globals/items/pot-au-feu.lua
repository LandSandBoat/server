-----------------------------------
-- ID: 5752
-- Item: Pot-au-feu
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -3
-- Ranged Attk % 15 Cap 60
-- Ranged ACC % 10 Cap 50
-- Enmity -3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5752)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_RATTP, 15)
    target:addMod(xi.mod.FOOD_RATT_CAP, 60)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 50)
    target:addMod(xi.mod.ENMITY, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_RATTP, 15)
    target:delMod(xi.mod.FOOD_RATT_CAP, 60)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 50)
    target:delMod(xi.mod.ENMITY, -3)
end

return itemObject
