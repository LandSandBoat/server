-----------------------------------
-- ID: 6459
-- Item: bowl_of_soy_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +55
-- STR +6
-- VIT +6
-- AGI +4
-- Attack +11% (cap 175)
-- Ranged Attack +11% (cap 175)
-- Resist Slow +15
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6459)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 55)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.FOOD_ATTP, 11)
    target:addMod(xi.mod.FOOD_ATT_CAP, 175)
    target:addMod(xi.mod.FOOD_RATTP, 11)
    target:addMod(xi.mod.FOOD_RATT_CAP, 175)
    target:addMod(xi.mod.SLOWRES, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 55)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.FOOD_ATTP, 11)
    target:delMod(xi.mod.FOOD_ATT_CAP, 175)
    target:delMod(xi.mod.FOOD_RATTP, 11)
    target:delMod(xi.mod.FOOD_RATT_CAP, 175)
    target:delMod(xi.mod.SLOWRES, 15)
end

return itemObject
