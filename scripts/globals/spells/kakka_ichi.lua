-----------------------------------
-- Spell: Kakka: Ichi
--     Grants Store TP +10 for Caster
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.STORE_TP
    caster:addStatusEffect(effect, 10, 0, 180)
    return effect
end

return spell_object
