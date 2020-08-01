-----------------------------------------
-- ID: 5930
-- Item: Bowl of Sprightly Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- MP 30
-- Mind 4
-- HP Recovered While Healing 4
-- Enmity -4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5930)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 30)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.HPHEAL, 4)
    target:addMod(tpz.mod.ENMITY, -4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 30)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.HPHEAL, 4)
    target:delMod(tpz.mod.ENMITY, -4)
end
