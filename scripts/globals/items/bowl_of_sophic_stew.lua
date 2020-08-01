-----------------------------------------
-- ID: 5180
-- Item: bowl_of_sophic_stew
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- Dexterity 6
-- Intelligence 6
-- Mind 6
-- HP Recovered While Healing 3
-- MP Recovered While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5180)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.INT, 6)
    target:addMod(tpz.mod.MND, 6)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.INT, 6)
    target:delMod(tpz.mod.MND, 6)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 3)
end
