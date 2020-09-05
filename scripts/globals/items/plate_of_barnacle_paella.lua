-----------------------------------------
-- ID: 5974
-- Item: Plate of Barnacle Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- HP 40
-- Vitality 5
-- Mind -1
-- Charisma -1
-- Defense % 25 Cap 150
-- Undead Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5974)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.CHR, -1)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 150)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.CHR, -1)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 150)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end
