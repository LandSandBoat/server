-----------------------------------
-- Spell: Tornado
-----------------------------------
require("scripts/globals/spells/damage_spell")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.ICE_MEVA)

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spell_object
