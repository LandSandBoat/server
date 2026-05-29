-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Theoyagudo Summoner
--  Job: SMN
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob)
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)
end

return entity