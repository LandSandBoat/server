-----------------------------------------
-- Spell: Warm-Up
-- Enhances accuracy and evasion
-- Spell cost: 59 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1
-- Level: 68
-- Casting Time: 7 seconds
-- Recast Time: 120 seconds
-- Duration: 180 seconds
--
-- Combos: Clear Mind
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffectOne = tpz.effect.ACCURACY_BOOST
    local typeEffectTwo = tpz.effect.EVASION_BOOST
    local power = 10
    local duration = 180
    local returnEffect = typeEffectOne

    if (caster:hasStatusEffect(tpz.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffectOne, power, 0, duration) == false and target:addStatusEffect(typeEffectTwo, power, 0, duration) == false) then -- both statuses fail to apply
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif (target:addStatusEffect(typeEffectOne, power, 0, duration) == false) then -- the first status fails to apply
        target:addStatusEffect(typeEffectTwo, power, 0, duration)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        returnEffect = typeEffectTwo
    else
        target:addStatusEffect(typeEffectOne, power, 0, duration)
        target:addStatusEffect(typeEffectTwo, power, 0, duration)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    end

    return returnEffect
end
