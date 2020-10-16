-----------------------------------------
-- Trust: Mihli Aliapoh
-----------------------------------------
require("scripts/globals/roe")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Mihli Aliapoh
    if caster:getEminenceProgress(934) then
        tpz.roe.onRecordTrigger(caster, 934)
    end

    return tpz.trust.spawn(caster, spell)
end
