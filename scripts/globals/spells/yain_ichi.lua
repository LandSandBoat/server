--------------------------------------
--     Spell: Yain: Ichi
--     Grants Enmity Down +15 for Caster
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    caster:delStatusEffect(tpz.effect.ENMITY_BOOST)

    caster:addStatusEffect(tpz.effect.PAX, 15, 0, 300)
    return tpz.effect.PAX
end
