-----------------------------------------
-- ID: 6274
-- Item: pukatrice_egg
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +15
-- MP +15
-- STR +2
-- Fire resistance +20
-- Attack +20% (cap 85)
-- Ranged Attack +20% (cap 85)
-- Subtle Blow +8
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6274)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 15)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.FIRERES, 20)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:addMod(tpz.mod.SUBTLE_BLOW, 8)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 15)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.FIRERES, 20)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 85)
    target:delMod(tpz.mod.SUBTLE_BLOW, 8)
end
