-----------------------------------
-- ID: 4295
-- Item: plate_of_royal_sautee
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Attack +22% (cap 80)
-- Ranged Attack +22% (cap 80)
-- Stun Resist +4
-- HP recovered while healing +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4295)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.FOOD_ATTP, 22)
    target:addMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addMod(xi.mod.FOOD_RATTP, 22)
    target:addMod(xi.mod.FOOD_RATT_CAP, 80)
    target:addMod(xi.mod.STUNRES, 4)
    target:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.FOOD_ATTP, 22)
    target:delMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delMod(xi.mod.FOOD_RATTP, 22)
    target:delMod(xi.mod.FOOD_RATT_CAP, 80)
    target:delMod(xi.mod.STUNRES, 4)
    target:delMod(xi.mod.HPHEAL, 1)
end

return itemObject
