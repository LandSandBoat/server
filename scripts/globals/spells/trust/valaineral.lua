-----------------------------------------
-- Trust: Valaineral
-----------------------------------------
require("scripts/globals/roe")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Valaineral
    if caster:getEminenceProgress(933) then
        tpz.roe.onRecordTrigger(caster, 933)
    end

    return tpz.trust.spawn(caster, spell)
end
