-----------------------------------
-- Spell: Threnody II - xi.mod.EARTH_MEVA
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster,target,spell)
    return 0
end

spell_object.onSpellCast = function(caster,target,spell)
    return handleThrenody(caster, target, spell, 160, 90, xi.mod.EARTH_MEVA)
end

return spell_object
