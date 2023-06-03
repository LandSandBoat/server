-----------------------------------
-- Trust: Sakura
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

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

    mob:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 6, 3, 0, xi.effect.GEO_REGEN, tick_amount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    mob:setAutoAttackEnabled(false)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
