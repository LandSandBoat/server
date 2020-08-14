--------------------------------------
-- Spell: Kakka: Ichi
--     Grants Store TP +10 for Caster
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.STORE_TP
    caster:addStatusEffect(effect, 10, 0, 180)
    return effect
end
