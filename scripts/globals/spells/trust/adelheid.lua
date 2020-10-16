-----------------------------------------
-- Trust: Adelheid
-----------------------------------------
require("scripts/globals/roe")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Adelheid
    if caster:getEminenceProgress(936) then
        tpz.roe.onRecordTrigger(caster, 936)
    end

    return tpz.trust.spawn(caster, spell)
end

