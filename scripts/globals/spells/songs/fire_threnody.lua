-----------------------------------
-- Spell: Threnody - xi.mod.FIRE_RES
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return handleThrenody(caster, target, spell, 50, 60, xi.mod.FIRE_RES)
end

return spell_object
