-----------------------------------------
-- ID: 4605
-- Item: Naval Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +12
-- Dex +3
-- Vit +3
-- hHP +2
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +40
-- Def +40
-- Arcana Killer (guesstimated 5%)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4605)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 12)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 12)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
end
