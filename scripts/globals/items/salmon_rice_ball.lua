-----------------------------------------
-- ID: 4590
-- Item: Salmon Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +10
-- Dex +2
-- Vit +2
-- Mnd -1
-- hHP +1
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +40
-- Def +40
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4590)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.HPHEAL, 1)
end
