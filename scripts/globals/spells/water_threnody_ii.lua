-----------------------------------
-- Spell: Threnody II - xi.mod.WATER_RES
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster,target,spell)
    return 0
end

spell_object.onSpellCast = function(caster,target,spell)
    return handleThrenody(caster, target, spell, 160, 90, xi.mod.WATER_RES)
end

return spell_object
