-----------------------------------
-- ID: 4502
-- Item: Marron Glace
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic % 13
-- Magic Cap 85
-- Magic Regen While Healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4502)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 13)
    target:addMod(xi.mod.FOOD_MP_CAP, 85)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 13)
    target:delMod(xi.mod.FOOD_MP_CAP, 85)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
