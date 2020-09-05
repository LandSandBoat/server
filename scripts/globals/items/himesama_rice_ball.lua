-----------------------------------------
-- ID: 5928
-- Item: Himesama Rice Ball
-- Food Effect: 30 Mins, All Races
-----------------------------------------
-- HP +25
-- Dexterity +4
-- Vitality +4
-- Character +4
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Attack +60
-- Defense +40
-- Triple Attack +1%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5928)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.CHR, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.CHR, 4)
end
