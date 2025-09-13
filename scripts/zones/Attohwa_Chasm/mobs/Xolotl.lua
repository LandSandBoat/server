-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-- Note: The 2 pets do NOT despawn if engaged when Xolotl dies, nor do they despawn if Xolotl disengages
--       Xolotl spawns one pet a time, with a 60s delay between (and after engaging)
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.ATTOHWA_CHASM]

local pets =
{
    ID.mob.XOLOTL + 1,
    ID.mob.XOLOTL + 2,
}

local callPetParams =
{
    superLink = true,
    maxSpawns = 1,
    inactiveTime = 3000,
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setRespawnTime(0)
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('pet_spawn_time', GetSystemTime() + 60)
end

entity.onMobFight = function(mob)
    if
        mob:getLocalVar('pet_spawn_time') < GetSystemTime() and
        xi.mob.callPets(mob, pets, callPetParams)
    then
        mob:setLocalVar('pet_spawn_time', GetSystemTime() + 60)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)
    end
end

entity.onMobDespawn = function(mob)
    -- Do not respawn Xolotl for 21-24 hours
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
