-----------------------------------
-- Spell: Aurorastorm
--     Changes the weather around target party member to "auroras."
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    target:delStatusEffectSilent(xi.effect.FIRESTORM)
    target:delStatusEffectSilent(xi.effect.SANDSTORM)
    target:delStatusEffectSilent(xi.effect.RAINSTORM)
    target:delStatusEffectSilent(xi.effect.WINDSTORM)
    target:delStatusEffectSilent(xi.effect.HAILSTORM)
    target:delStatusEffectSilent(xi.effect.THUNDERSTORM)
    target:delStatusEffectSilent(xi.effect.AURORASTORM)
    target:delStatusEffectSilent(xi.effect.VOIDSTORM)

    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 48, target:getMainLvl())

    local merit = caster:getMerit(xi.merit.STORMSURGE)
    local power = 0
    if merit > 0 then
        power = merit + caster:getMod(xi.mod.STORMSURGE_EFFECT) + 2
    end

    target:addStatusEffect(xi.effect.AURORASTORM, power, 0, duration)
    return xi.effect.AURORASTORM
end

return spell_object
