-----------------------------------
-- Spell: Escape
-----------------------------------
require("scripts/globals/spells/spell_enhancing_teleport")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.spell_enhancing_teleport.useTeleportSpell(caster, target, spell)
end

return spell_object
