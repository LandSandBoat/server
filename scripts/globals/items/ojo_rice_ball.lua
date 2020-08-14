-----------------------------------------
-- ID: 5929
-- Item: Ojo Rice Ball
-- Food Effect: 60 Mins, All Races
-----------------------------------------
-- HP +50
-- Dexterity +5
-- Vitality +5
-- Character +5
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Attack +60
-- Defense +40
-- Triple Attack +2%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5929)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 50)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.CHR, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 50)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.CHR, 5)
end
