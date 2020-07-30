--------------------------------------
-- Spell: Myoshu: Ichi
--     Grants Subtle Blow +10 for Caster
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.SUBTLE_BLOW_PLUS
    caster:addStatusEffect(effect, 10, 0, 180)
    return effect
end
