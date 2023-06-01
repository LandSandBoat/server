-----------------------------------
-- ID: 5892
-- Item: b.e.w._pitaru
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +9% (cap 130)
-- Increases rate of magic skill gains by 80%
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5892)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 9)
    target:addMod(xi.mod.FOOD_MP_CAP, 130)
    target:addMod(xi.mod.MAGIC_SKILLUP_RATE, 80)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 9)
    target:delMod(xi.mod.FOOD_MP_CAP, 130)
    target:delMod(xi.mod.MAGIC_SKILLUP_RATE, 80)
end

return itemObject
