-----------------------------------------
-- ID: 6406
-- Item: pork_cutlet_rice_bowl
-- Food Effect: 180Min, All Races
-----------------------------------------
-- HP +60
-- MP +60
-- STR +7
-- VIT +3
-- AGI +5
-- INT -7
-- Fire resistance +20
-- Attack +23% (cap 125)
-- Ranged Attack +23% (cap 125)
-- Store TP +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6406)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 60)
    target:addMod(tpz.mod.MP, 60)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.INT, -7)
    target:addMod(tpz.mod.FIRERES, 20)
    target:addMod(tpz.mod.FOOD_ATTP, 23)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 125)
    target:addMod(tpz.mod.FOOD_RATTP, 23)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 125)
    target:addMod(tpz.mod.STORETP, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 60)
    target:delMod(tpz.mod.MP, 60)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.INT, -7)
    target:delMod(tpz.mod.FIRERES, 20)
    target:delMod(tpz.mod.FOOD_ATTP, 23)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 125)
    target:delMod(tpz.mod.FOOD_RATTP, 23)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 125)
    target:delMod(tpz.mod.STORETP, 4)
end
