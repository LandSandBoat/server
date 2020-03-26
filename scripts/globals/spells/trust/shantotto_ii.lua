-----------------------------------------
-- Trust: Shantotto II
-----------------------------------------
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 896)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end
