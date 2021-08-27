-----------------------------------
-- Spell: Auspice
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.AUSPICE
    doEnspell(caster, target, spell, effect)
    return effect
end

return spell_object
