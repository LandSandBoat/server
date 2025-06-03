-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Cemetery Cherry
-- !pos 33.000 0.500 -287.000 190
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function spawnSaplings()
    for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
        local mob = GetMobByID(i)
        if mob ~= nil and mob:getName() == 'Cherry_Sapling' and not mob:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 10000)
    mob:addImmunity(xi.immunity.SILENCE)

    local saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    mob:timer(saplingsRespawn * 1000, function(mobArg)
        spawnSaplings()
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('wasKilled', 0)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('wasKilled', 1)
    player:addTitle(xi.title.MON_CHERRY)
end

entity.onMobDespawn = function(mob)
    local saplingsRespawn = math.random(1800, 3600) -- 30 to 60 minutes
    if mob:getLocalVar('wasKilled') == 1 then
        saplingsRespawn = math.random(216000, 259200) -- 60 to 72 hours
    end

    mob:timer(saplingsRespawn * 1000, function(mobArg)
        spawnSaplings()
    end)
end

return entity
