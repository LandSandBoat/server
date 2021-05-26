-----------------------------------
-- Spell: Flood II
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
    -- no point in making a separate function for this if the only thing they won't have in common is the name
    handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.THUNDERRES)

    return xi.magic_utils.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
