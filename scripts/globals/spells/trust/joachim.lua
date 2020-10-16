-----------------------------------------
-- Trust: Joachim
-----------------------------------------
require("scripts/globals/roe")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Joachim
    if caster:getEminenceProgress(937) then
        tpz.roe.onRecordTrigger(caster, 937)
    end

    return tpz.trust.spawn(caster, spell)
end
