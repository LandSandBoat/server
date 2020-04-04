-----------------------------------------
-- Trust: Excenmille
-----------------------------------------
require("scripts/globals/trust")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1004)
end

function onSpellCast(caster, target, spell)
    local SandoriaFirstTrust = caster:getCharVar("SandoriaFirstTrust")
    local zone = caster:getZoneID()

    if SandoriaFirstTrust == 1 and (zone == tpz.zone.WEST_RONFAURE or zone == tpz.zone.EAST_RONFAURE) then
        caster:setCharVar("SandoriaFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end
