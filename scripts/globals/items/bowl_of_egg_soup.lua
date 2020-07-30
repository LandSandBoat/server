-----------------------------------------
-- ID: 4417
-- Item: Bowl of Egg Soup
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health % 6
-- Health Cap 30
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4417)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 30)
    target:addMod(tpz.mod.MP, 5)
    target:addMod(tpz.mod.HPHEAL, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 30)
    target:delMod(tpz.mod.MP, 5)
    target:delMod(tpz.mod.HPHEAL, 5)
end
