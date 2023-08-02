-----------------------------------
-- ID: 5713
-- Item: orange_snow_cone
-- Food Effect: 5 Min, All Races
-----------------------------------
-- MP +20% (cap 20)
-- AGI -1
-- INT +1
-- Wind resistance +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5713)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 20)
    target:addMod(xi.mod.FOOD_MP_CAP, 20)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 20)
    target:delMod(xi.mod.FOOD_MP_CAP, 20)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.WIND_MEVA, 5)
end

return itemObject
