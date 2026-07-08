-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Nasus
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 15 })
end

entity.onMobDeath = function(mob, player, optParams)
    local qm = GetNPCByID(ID.npc.TUNING_OUT_QM)

    if qm then
        qm:setLocalVar('NasusKilled', qm:getLocalVar('NasusKilled') + 1)
    end
end

return entity
