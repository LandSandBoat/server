-----------------------------------
-- Spell: Flood
-----------------------------------
require("scripts/globals/spells/damage_spell")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- no point in making a separate function for this if the only thing they won't have in common is the name
    xi.magic.handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.THUNDER_MEVA)

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
