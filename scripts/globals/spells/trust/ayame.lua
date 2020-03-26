-----------------------------------------
-- Trust: Ayame
-----------------------------------------
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1005)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end
