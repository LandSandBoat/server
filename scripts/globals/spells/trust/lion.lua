-----------------------------------
-- Trust: Lion
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1009)
end

spell_object.onSpellCast = function(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

return spell_object
