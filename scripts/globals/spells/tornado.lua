-----------------------------------
-- Spell: Tornado
-----------------------------------
require("scripts/globals/magic_utils/spell_damage")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.ICERES)

    return xi.magic_utils.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
