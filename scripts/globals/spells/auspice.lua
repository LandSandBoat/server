-----------------------------------------
--
-- Spell: Auspice
--
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.AUSPICE
    doEnspell(caster, target, spell, effect)
    return effect
end
