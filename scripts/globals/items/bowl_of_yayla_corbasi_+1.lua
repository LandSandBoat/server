-----------------------------------------
-- ID: 5580
-- Item: bowl_of_yayla_corbasi_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP 25
-- Dexterity -1
-- Vitality 3
-- HP Recovered While Healing 5
-- MP Recovered While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5580)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.MPHEAL, 2)
end
