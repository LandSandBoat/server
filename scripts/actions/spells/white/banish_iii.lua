-----------------------------------
-- Spell: Banish III
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    xi.spells.enfeebling.handleDamageSpellEnfeeble(caster, target, spell)

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
