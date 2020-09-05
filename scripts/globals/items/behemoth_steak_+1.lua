-----------------------------------------
-- ID: 6465
-- Item: behemoth_steak_+1
-- Food Effect: 240Min, All Races
-----------------------------------------
-- HP +45
-- STR +8
-- DEX +8
-- INT -4
-- Attack +24% (cap 165)
-- Ranged Attack +24% (cap 165)
-- Triple Attack +2%
-- Lizard Killer +5
-- hHP +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6465)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 45)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.DEX, 8)
    target:addMod(tpz.mod.INT, -4)
    target:addMod(tpz.mod.FOOD_ATTP, 24)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 165)
    target:addMod(tpz.mod.FOOD_RATTP, 24)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 165)
    target:addMod(tpz.mod.TRIPLE_ATTACK, 2)
    target:addMod(tpz.mod.LIZARD_KILLER, 5)
    target:addMod(tpz.mod.HPHEAL, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 45)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.DEX, 8)
    target:delMod(tpz.mod.INT, -4)
    target:delMod(tpz.mod.FOOD_ATTP, 24)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 165)
    target:delMod(tpz.mod.FOOD_RATTP, 24)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 165)
    target:delMod(tpz.mod.TRIPLE_ATTACK, 2)
    target:delMod(tpz.mod.LIZARD_KILLER, 5)
    target:delMod(tpz.mod.HPHEAL, 5)
end
