-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Contantican Black Mage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.expeditionaryForce.onMobDeath(mob, player)
    end
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)
end

return entity
