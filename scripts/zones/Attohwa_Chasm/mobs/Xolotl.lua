-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-- Note: The 2 pets do NOT despawn if engaged when Xolotl dies, nor do they
--       despawn if Xolotl disengages. Xolotl spawns one pet a time, with a
--       separate timer for each pet, 60 seconds after engaging and 60
--       seconds after the pet dies.
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.ATTOHWA_CHASM]

local pets =
{
    ID.mob.XOLOTL + 1, -- Xolotl's Hound Warrior
    ID.mob.XOLOTL + 2, -- Xolotl's Sacrifice
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
    mob:setLocalVar('hound_spawn_time', GetSystemTime() + 60)
    mob:setLocalVar('sacrifice_spawn_time', GetSystemTime() + 60)
end

entity.onMobFight = function(mob)
    if mob:getLocalVar('hound_spawn_time') < GetSystemTime() then
        xi.mob.callPets(mob, pets[1], callPetParams)
    end

    if mob:getLocalVar('sacrifice_spawn_time') < GetSystemTime() then
        xi.mob.callPets(mob, pets[2], callPetParams)
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
