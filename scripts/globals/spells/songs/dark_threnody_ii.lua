-----------------------------------
-- Spell: Threnody II - xi.mod.DARK_MEVA
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return handleThrenody(caster, target, spell, 160, 90, xi.mod.DARK_MEVA)
end

return spellObject
