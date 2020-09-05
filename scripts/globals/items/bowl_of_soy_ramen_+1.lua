-----------------------------------------
-- ID: 6459
-- Item: bowl_of_soy_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- HP +55
-- STR +6
-- VIT +6
-- AGI +4
-- Attack +11% (cap 175)
-- Ranged Attack +11% (cap 175)
-- Resist Slow +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6459)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 55)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_ATTP, 11)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 175)
    target:addMod(tpz.mod.FOOD_RATTP, 11)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 175)
    target:addMod(tpz.mod.SLOWRES, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 55)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_ATTP, 11)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 175)
    target:delMod(tpz.mod.FOOD_RATTP, 11)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 175)
    target:delMod(tpz.mod.SLOWRES, 15)
end
