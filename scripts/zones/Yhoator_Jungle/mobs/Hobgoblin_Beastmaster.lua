-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Hobgoblin Beastmaster
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bee')
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
