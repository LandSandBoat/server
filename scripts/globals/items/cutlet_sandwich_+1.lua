-----------------------------------
-- ID: 6397
-- Item: cutlet_sandwich_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +45
-- STR +8
-- INT -8
-- Fire resistance +21
-- Attack +21% (cap 125)
-- Ranged Attack +21% (cap 125)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6397)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.STR, 8)
    target:addMod(xi.mod.INT, -8)
    target:addMod(xi.mod.FIRE_MEVA, 21)
    target:addMod(xi.mod.FOOD_ATTP, 21)
    target:addMod(xi.mod.FOOD_ATT_CAP, 125)
    target:addMod(xi.mod.FOOD_RATTP, 21)
    target:addMod(xi.mod.FOOD_RATT_CAP, 125)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.STR, 8)
    target:delMod(xi.mod.INT, -8)
    target:delMod(xi.mod.FIRE_MEVA, 21)
    target:delMod(xi.mod.FOOD_ATTP, 21)
    target:delMod(xi.mod.FOOD_ATT_CAP, 125)
    target:delMod(xi.mod.FOOD_RATTP, 21)
    target:delMod(xi.mod.FOOD_RATT_CAP, 125)
end

return itemObject
