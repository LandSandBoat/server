-----------------------------------------
-- ID: 6407
-- Item: pork_cutlet_rice_bowl_+1
-- Food Effect: 240Min, All Races
-----------------------------------------
-- HP +65
-- MP +65
-- STR +8
-- VIT +4
-- AGI +6
-- INT -8
-- Fire resistance +21
-- Attack +24% (cap 130)
-- Ranged Attack +24% (cap 130)
-- Store TP +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6407)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 65)
    target:addMod(tpz.mod.MP, 65)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.INT, -8)
    target:addMod(tpz.mod.FIRERES, 21)
    target:addMod(tpz.mod.FOOD_ATTP, 24)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 130)
    target:addMod(tpz.mod.FOOD_RATTP, 24)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 130)
    target:addMod(tpz.mod.STORETP, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 65)
    target:delMod(tpz.mod.MP, 65)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.INT, -8)
    target:delMod(tpz.mod.FIRERES, 21)
    target:delMod(tpz.mod.FOOD_ATTP, 24)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 130)
    target:delMod(tpz.mod.FOOD_RATTP, 24)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 130)
    target:delMod(tpz.mod.STORETP, 5)
end
