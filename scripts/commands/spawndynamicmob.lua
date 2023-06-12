-----------------------------------
-- func: !spawndynamicmob <Mob's Group ID> <Mob's Zone ID> { Number of Mobs } { Name for the Mob } { dropsEnabled (1/0) } { Costume Finder (1/0) }
-- desc: Spawn a dynamic mob exactly matching that of a normal mob.
-- note: Original code from zach2Good's Fafnir.lua
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = "iiiiisii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawndynamicmob <Mob's Group ID> <Mob's Zone ID> { Number of Mobs } { Name for the Mob } { dropsEnabled (1/0) } { Costume Finder (1/0) }")
end

function onTrigger(player, mobGroupID, mobZoneID, numberOfMob, mobLook, mobName, dropsEnabled, costumeFinder)
    local i = 1
    local mobLookActive = mobLook

    -- Make Mob Name Optional
    if mobName == nil then
        mobName = "NPC"
    else
        mobName = mobName
    end

    if numberOfMob == nil then
        numberOfMob = 1
    end

    if mobZoneID == nil then
        error(player, "You must provide a mob's zone ID.")
        return
    end

    if mobGroupID == nil then
        error(player, "You must provide a group ID.")
        return
    end

    if mobLook ~= nil then
        while i <= numberOfMob do

            if numberOfMob > 1 and costumeFinder == 1 then
                mobName = string.format("%i", mobLookActive)
            end

            local zone = player:getZone()
            local mob = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = mobName,
                x = player:getXPos(),
                y = player:getYPos(),
                z = player:getZPos(),
                rotation = player:getRotPos(),
                groupId = mobGroupID,
                groupZoneId = mobZoneID,
                look = mobLookActive,
                onMobDeath = function(mob, playerArg, optParams)
                end,
            })

            -- Use the mob object as you normally would
            mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

            if dropsEnabled == 0 or dropsEnabled == nil then
                mob:setDropID(0) -- No loot!
            end

            mob:spawn()

            --player:PrintToPlayer("Spawning: ".. mobName ..", Mob ID: ".. mob:getID() ..", Mob Main Level: ".. mob:getMainLvl())
            player:PrintToPlayer(string.format("Spawning %s: (ID: %i) (Level: %i)", mob:getName(), mob:getID(), mob:getMainLvl()))
            i = i + 1
            mobLookActive = mobLookActive + 1
        end
    else
        while i <= numberOfMob do
            local zone = player:getZone()
            local mob = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = mobName,
                x = player:getXPos(),
                y = player:getYPos(),
                z = player:getZPos(),
                rotation = player:getRotPos(),
                groupId = mobGroupID,
                groupZoneId = mobZoneID,
                onMobDeath = function(mob, playerArg, optParams)
                end,
            })

            -- Use the mob object as you normally would
            mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

            if dropsEnabled == 0 or dropsEnabled == nil then
                mob:setDropID(0) -- No loot!
            end

            mob:spawn()

            --player:PrintToPlayer("Spawning: ".. mobName ..", Mob ID: ".. mob:getID() ..", Mob Main Level: ".. mob:getMainLvl())
            player:PrintToPlayer(string.format("Spawning %s: (ID: %i) (Level: %i)", mob:getName(), mob:getID(), mob:getMainLvl()))
            i = i + 1
        end
    end
end
