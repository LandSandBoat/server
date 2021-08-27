-----------------------------------
--     Spell: Yain: Ichi
--     Grants Enmity Down +15 for Caster
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
    caster:delStatusEffect(xi.effect.ENMITY_BOOST)

    caster:addStatusEffect(xi.effect.PAX, 15, 0, 300)
    return xi.effect.PAX
end

return spell_object
