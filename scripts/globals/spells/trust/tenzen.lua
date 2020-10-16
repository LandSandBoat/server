-----------------------------------------
-- Trust: Tenzen
-----------------------------------------
require("scripts/globals/roe")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1014)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Tenzen
    if caster:getEminenceProgress(935) then
        tpz.roe.onRecordTrigger(caster, 935)
    end

    return tpz.trust.spawn(caster, spell)
end
