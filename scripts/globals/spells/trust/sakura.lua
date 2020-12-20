-----------------------------------------
-- Trust: Sakura
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------------

local message_page_offset = 31

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.SPAWN)

    local mlvl = mob:getMainLvl()
    local tick_amount
    if mlvl == 99 then
        tick_amount = 6
    elseif mlvl < 99 then
        tick_amount = 5
    elseif mlvl <= 87 then
        tick_amount = 4
    elseif mlvl <= 73 then
        tick_amount = 3
    elseif mlvl <= 51 then
        tick_amount = 2
    else
        tick_amount = 1
    end

    mob:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 6, 3, 0, tpz.effect.GEO_REGEN, tick_amount, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
    mob:SetAutoAttackEnabled(false)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
