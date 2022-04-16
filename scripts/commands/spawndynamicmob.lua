-----------------------------------
-- func: spawndynamicmob <Mob's Group ID> <Mob's Zone ID> <Number of Mobs> <Name for the Mob>
-- desc: Spawn a dynamic mob exactly matching that of a normal mob.
-- note:
-----------------------------------

cmdprops =
{
    permission = 2,
    parameters = "iiisi"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawndynamicmob <Mob's Group ID> <Mob's Zone ID> <Number of Mobs> <Name for the Mob> {dropsEnabled (0 == False, 1 == True)}")
end

function onTrigger(player, mobGroupID, mobZoneID, numberOfMob, mobName, dropsEnabled)
    local i = 1

    if mobName == nil then
        error(player, "You must provide a name for the mob.")
        return
    end

    if numberOfMob == nil then
        error(player, "You must provide the number of mobs you want to spawn.")
        return
    end

    if mobZoneID == nil then
        error(player, "You must provide a mob's zone ID.")
        return
    end

    if mobGroupID == nil then
        error(player, "You must provide a group ID.")
        return
    end

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
    
            onMobDeath = function(mob, playerArg, isKiller)
            end,
        })

        -- Use the mob object as you normally would
        mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

        if dropsEnabled == 0 or dropsEnabled == nil then
            mob:setDropID(0) -- No loot!
        end

        mob:spawn()

        player:PrintToPlayer("Spawning: ".. mobName ..", Mob ID: ".. mob:getID() ..", Mob Main Level: ".. mob:getMainLvl())
        i = i + 1
    end
end
