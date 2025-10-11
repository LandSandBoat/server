-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Pevv the Riverleaper
-- BCNM: Amphibian Assault
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Sahagins_Wyvern')
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.CALL_WYVERN, hpp = 75 },
        },
    })
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    local pet   = GetMobByID(mobId + 2)

    if
        pet and
        pet:isSpawned() and
        pet:getCurrentAction() == xi.action.ROAMING
    then
        pet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    DespawnMob(mob:getID() + 2)
end

return entity
