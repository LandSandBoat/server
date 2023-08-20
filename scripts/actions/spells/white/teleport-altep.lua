-----------------------------------
-- Spell: Teleport-Altep
-----------------------------------
require("scripts/globals/spells/enhancing_teleport")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spellObject
