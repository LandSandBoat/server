-----------------------------------------
-- ID: 4521
-- Item: Bowl of Humpty Soup
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Health % 6
-- Health Cap 35
-- Magic 5
-- Health Regen While Healing 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4521)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 35)
    target:addMod(tpz.mod.MP, 5)
    target:addMod(tpz.mod.HPHEAL, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 35)
    target:delMod(tpz.mod.MP, 5)
    target:delMod(tpz.mod.HPHEAL, 5)
end
