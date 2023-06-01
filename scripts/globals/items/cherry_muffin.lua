-----------------------------------
-- ID: 5653
-- Item: Cherry Muffin
-- Food Effect: 30Min, All Races
-----------------------------------
-- Intelligence 1
-- Magic % 10
-- Magic Cap 80
-- Agility -1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5653)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.FOOD_MPP, 10)
    target:addMod(xi.mod.FOOD_MP_CAP, 80)
    target:addMod(xi.mod.AGI, -1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.FOOD_MPP, 10)
    target:delMod(xi.mod.FOOD_MP_CAP, 80)
    target:delMod(xi.mod.AGI, -1)
end

return itemObject
