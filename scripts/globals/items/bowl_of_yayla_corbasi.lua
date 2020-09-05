-----------------------------------------
-- ID: 5579
-- Item: bowl_of_yayla_corbasi
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP 20
-- Dexterity -1
-- Vitality 2
-- HP Recovered While Healing 3
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5579)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 1)
end
