-----------------------------------
-- Spell: Threnody II - xi.mod.WINDRES
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster,target,spell)
    return 0
end

spell_object.onSpellCast = function(caster,target,spell)
    return handleThrenody(caster, target, spell, 160, 90, xi.mod.WINDRES)
end

return spell_object
