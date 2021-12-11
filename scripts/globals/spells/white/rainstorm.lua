-----------------------------------
-- Spell: Rainstorm
--     Changes the weather around target party member to "rainy."
-----------------------------------
require("scripts/globals/magic")
require("scripts/settings/main")
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
    duration = calculateDurationForLvl(duration, 42, target:getMainLvl())

    local merit = caster:getMerit(xi.merit.STORMSURGE)
    local power = 0
    if merit > 0 then
        power = merit + caster:getMod(xi.mod.STORMSURGE_EFFECT) + 2
    end

    target:addStatusEffect(xi.effect.RAINSTORM, power, 0, duration)

    return xi.effect.RAINSTORM
end

return spell_object
