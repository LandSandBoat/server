-----------------------------------
-- Spell: Retrace
-- Transports player to their Allied Nation. Can cast on allies.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.spells.enhancing.checkTeleportSpell(caster, target, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spellObject
