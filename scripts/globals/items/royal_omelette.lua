-----------------------------------------
-- ID: 4564
-- Item: royal_omelette
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Strength 5
-- Dexterity 2
-- Intelligence -3
-- Mind 4
-- Attack % 20 (cap 65)
-- Ranged Attack % 20 (cap 65)
-----------------------------------------
-- IF ELVAAN ONLY
-- HP 20
-- MP 20
-- Strength 6
-- Dexterity 2
-- Intelligence -2
-- Mind 5
-- Charisma 4
-- Attack % 22
-- Attack Cap 80
-- Ranged ATT % 22
-- Ranged ATT Cap 80
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4564)
end

function onEffectGain(target, effect)
    if (target:getRace() == tpz.race.ELVAAN_M or target:getRace() == tpz.race.ELVAAN_F) then
        target:addMod(tpz.mod.HP, 20)
        target:addMod(tpz.mod.MP, 20)
        target:addMod(tpz.mod.STR, 6)
        target:addMod(tpz.mod.DEX, 2)
        target:addMod(tpz.mod.INT, -2)
        target:addMod(tpz.mod.MND, 5)
        target:addMod(tpz.mod.CHR, 4)
        target:addMod(tpz.mod.FOOD_ATTP, 22)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
        target:addMod(tpz.mod.FOOD_RATTP, 22)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
    else
        target:addMod(tpz.mod.STR, 5)
        target:addMod(tpz.mod.DEX, 2)
        target:addMod(tpz.mod.INT, -3)
        target:addMod(tpz.mod.MND, 4)
        target:addMod(tpz.mod.FOOD_ATTP, 20)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
        target:addMod(tpz.mod.FOOD_RATTP, 20)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
    end
end

function onEffectLose(target, effect)
    if (target:getRace() == tpz.race.ELVAAN_M or target:getRace() == tpz.race.ELVAAN_F) then
        target:delMod(tpz.mod.HP, 20)
        target:delMod(tpz.mod.MP, 20)
        target:delMod(tpz.mod.STR, 6)
        target:delMod(tpz.mod.DEX, 2)
        target:delMod(tpz.mod.INT, -2)
        target:delMod(tpz.mod.MND, 5)
        target:delMod(tpz.mod.CHR, 4)
        target:delMod(tpz.mod.FOOD_ATTP, 22)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
        target:delMod(tpz.mod.FOOD_RATTP, 22)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
    else
        target:delMod(tpz.mod.STR, 5)
        target:delMod(tpz.mod.DEX, 2)
        target:delMod(tpz.mod.INT, -3)
        target:delMod(tpz.mod.MND, 4)
        target:delMod(tpz.mod.FOOD_ATTP, 20)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
        target:delMod(tpz.mod.FOOD_RATTP, 20)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
    end
end
