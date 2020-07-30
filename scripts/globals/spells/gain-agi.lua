--------------------------------------
-- Spell: Gain-AGI
--     Boosts AGI for the Caster
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.AGI_BOOST
    doBoostGain(caster, target, spell, effect)
    return effect
end
