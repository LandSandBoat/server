-----------------------------------------
-- ID: 6458
-- Item: bowl_of_soy_ramen
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +50
-- STR +5
-- VIT +5
-- AGI +3
-- Attack +10% (cap 170)
-- Ranged Attack +10% (cap 170)
-- Resist Slow +10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6458)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 50)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 170)
    target:addMod(tpz.mod.FOOD_RATTP, 10)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 170)
    target:addMod(tpz.mod.SLOWRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 50)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 170)
    target:delMod(tpz.mod.FOOD_RATTP, 10)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 170)
    target:delMod(tpz.mod.SLOWRES, 10)
end
