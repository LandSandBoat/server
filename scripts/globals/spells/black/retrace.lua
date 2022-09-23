-----------------------------------
-- Spell: Retrace
-- Transports player to their Allied Nation. Can cast on allies.
-----------------------------------
require("scripts/globals/spells/enhancing_teleport")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.spells.enhancing.checkTeleportSpell(caster, target, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spell_object
