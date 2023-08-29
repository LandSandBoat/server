-----------------------------------
-- Spell: Tornado
-----------------------------------
require("scripts/globals/spells/damage_spell")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    xi.magic.handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.ICE_MEVA)

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
