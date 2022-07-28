-----------------------------------
-- Spell: Teleport-Altep
-----------------------------------
require("scripts/globals/spells/enhancing_teleport")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spell_object
