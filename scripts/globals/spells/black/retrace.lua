-----------------------------------
-- Spell: Retrace
-- Transports player to their Allied Nation. Can cast on allies.
-----------------------------------
require("scripts/globals/spells/spell_enhancing_teleport")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.spells.spell_enhancing_teleport.checkTeleportSpell(caster, target, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.spell_enhancing_teleport.useTeleportSpell(caster, target, spell)
end

return spell_object
