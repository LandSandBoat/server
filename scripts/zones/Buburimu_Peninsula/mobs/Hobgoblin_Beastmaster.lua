-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Hobgoblin Beastmaster
--  Job: BST
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Rabbit')
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minute idle despawn
end

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob, player, optParams)

    -- BST pets aren't auto-killed on death (only SMN pets are), so clean it up
    local pet = mob:getPet()
    if pet then
        DespawnMob(pet:getID())
    end
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)

    -- Idle despawn doesn't clean up the pet, so do it here
    local pet = mob:getPet()
    if pet then
        DespawnMob(pet:getID())
    end
end

return entity
