--------------------------------------
-- Spell: Thunderstorm
--     Changes the weather around target party member to "thundery."
--------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    target:delStatusEffectSilent(tpz.effect.FIRESTORM)
    target:delStatusEffectSilent(tpz.effect.SANDSTORM)
    target:delStatusEffectSilent(tpz.effect.RAINSTORM)
    target:delStatusEffectSilent(tpz.effect.WINDSTORM)
    target:delStatusEffectSilent(tpz.effect.HAILSTORM)
    target:delStatusEffectSilent(tpz.effect.THUNDERSTORM)
    target:delStatusEffectSilent(tpz.effect.AURORASTORM)
    target:delStatusEffectSilent(tpz.effect.VOIDSTORM)

    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 46, target:getMainLvl())

    local merit = caster:getMerit(tpz.merit.STORMSURGE)
    local power = 0
    if merit > 0 then
        power = merit + caster:getMod(tpz.mod.STORMSURGE_EFFECT) + 2
    end

    target:addStatusEffect(tpz.effect.THUNDERSTORM, power, 0 , duration)

    return tpz.effect.THUNDERSTORM
end
