-----------------------------------
-- ID: 5690
-- Item: Meatloaf +1
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- Strength 6
-- Agility 2
-- Intelligence -3
-- Attack 18% Cap 95
-----------------------------------
require("scripts/globals/status")
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5690)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 95)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 95)
end

return itemObject
