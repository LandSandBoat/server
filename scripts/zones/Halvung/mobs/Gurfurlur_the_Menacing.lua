-----------------------------------
-- Area: Halvung
--  Mob: Gurfurlur the Menacing
-- !pos -59.000 -23.000 3.000 62
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local arena =
{
    x = -60, y = -23, z = 9
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobEngaged = function(mob, target)
    target:showText(mob, zones[mob:getZoneID()].text.GURFURLUR_ENGAGE)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    for id = mob:getID() + 1, mob:getID() + 4 do
        SpawnMob(id):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    local arenaArg =
    {
        condition1 = target:checkDistance(arena) > 15,
        position   = { arena.x + math.random(-3, 3), arena.y, arena.z + math.random(-3, 3), target:getRotPos() },
    }

    utils.arenaDrawIn(mob, target, arenaArg)

    for id = mob:getID() + 1, mob:getID() + 4 do
        local pet = GetMobByID(id)
        if
            not pet:isSpawned() and
            mob:getLocalVar("[GURFURLUR]respawnAdd" .. id) < os.time()
        then
            SpawnMob(id)
        end

        if
            pet:isAlive() and
            pet:getCurrentAction() == xi.act.ROAMING
        then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    -- Return to Throne
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:timer(10000, function(mobArg)
        local spawn = mobArg:getSpawnPos()
        mobArg:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
    end)

    for id = 1, 4 do
        DespawnMob(mob:getID() + id)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TROLL_SUBJUGATOR)
    player:showText(mob, zones[mob:getZoneID()].text.GURFURLUR_DEAD)

    for id = 1, 4 do
        DespawnMob(mob:getID() + id)
    end
end

entity.onMobDespawn = function(mob)
end

return entity
