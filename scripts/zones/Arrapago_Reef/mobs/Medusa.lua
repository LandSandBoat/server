-----------------------------------
-- Area: Arrapago Reef
--   NM: Medusa
-- !pos -458 -20 458
-- TODO: resists, attack/def boosts
--
-- Notes: It is possible that she will not use Eagle Eye Shot at all.
--  Medusa's draw in mechancss appear to take effect whenever the target leaves
--  a certain distance from the centre of the arena.
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local arena =
{
    x = -440, y = -17.6, z = 438
}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        chance = 75,
        specials =
        {
            { id = xi.jsa.EES_LAMIA, hpp = math.random(5, 99) },
        },
    })

    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngaged = function(mob, target)
    target:showText(mob, ID.text.MEDUSA_ENGAGE)
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
            mob:getLocalVar("[MEDUSA]respawnAdd" .. id) < os.time()
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
    player:showText(mob, ID.text.MEDUSA_DEATH)
    player:addTitle(xi.title.GORGONSTONE_SUNDERER)

    for id = 1, 4 do
        DespawnMob(mob:getID() + id)
    end
end

entity.onMobDespawn = function(mob)
end

return entity
