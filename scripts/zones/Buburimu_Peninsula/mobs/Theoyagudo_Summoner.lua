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
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minute idle despawn
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 2)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)

    -- Idle despawn doesn't clean up the pet, so do it here (death is handled by the engine)
    local pet = mob:getPet()
    if pet then
        DespawnMob(pet:getID())
    end
end

return entity