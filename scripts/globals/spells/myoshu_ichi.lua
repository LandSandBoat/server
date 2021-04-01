-----------------------------------
-- Spell: Myoshu: Ichi
--     Grants Subtle Blow +10 for Caster
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.SUBTLE_BLOW_PLUS
    caster:addStatusEffect(effect, 10, 0, 180)
    return effect
end

return spell_object
