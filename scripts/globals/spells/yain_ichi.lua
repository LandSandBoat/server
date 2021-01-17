-----------------------------------
--     Spell: Yain: Ichi
--     Grants Enmity Down +15 for Caster
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    caster:delStatusEffect(tpz.effect.ENMITY_BOOST)

    caster:addStatusEffect(tpz.effect.PAX, 15, 0, 300)
    return tpz.effect.PAX
end

return spell_object
