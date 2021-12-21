-----------------------------------
-- func: fafnir
-- desc: Spawn Fafnir, in any zone
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()
    local zoneName = zone:getName()
    local name = "Fafnir"

    local mobTable = {}
    mobTable.onMobSpawn = function(mobArg)
        print("Fafnir: I am spawning")
    end
    mobTable.onMobDespawn = function(mobArg)
        print("Fafnir: I am despawning")
    end
    mobTable.onMobDeath = function(mobArg)
        print("Fafnir: I am dead")
    end

    -- Build/insert cache entry
    xi.zones[zoneName] = xi.zones[zoneName] or {}
    xi.zones[zoneName].mobs = xi.zones[zoneName].mobs or {}
    xi.zones[zoneName].mobs[name] = mobTable

    -- Spawn mob
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        allegiance = xi.allegiance.MOB,
        name = "Fafnir",
        modelId = 783,
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),
    })

    -- TODO: These don't work
    -- Why is the spawn point elsewhere?
    mob:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())
    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

    -- TODO: This is needed because he will try to despawn and go home
    -- With this he tries to walk home
    mob:setUnkillable(true)

    --mob:updateClaim(player)

    print(string.format("GM Spawning %s in %s", mob, zoneName))
end
