-----------------------------------------
-- Trust: Curilla
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    local FLASH  = 112

    mob:addGambit(PARTY, HPP_LTE, 75, MA, SELECT_HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addGambit(TARGET, NOT_STATUS, tpz.effect.FLASH, MA, SELECT_SPECIFIC, FLASH)
end
