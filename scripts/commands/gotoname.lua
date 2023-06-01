-----------------------------------
-- func: gotoname
-- desc: Go to given mob or npc by name
-----------------------------------
cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!gotoname <mob or npc name> (index)")
end

-----------------------------------
-- func: getValidEntities
-- desc: given a list of entities, returns the ones that have valid coordinates
-----------------------------------
local getValidEntities = function(entities)
    local validEntities = {}
    for i, entity in pairs(entities) do
        local pos = entity:getPos()
        local invalidCoordinates = (pos.x == 0 and pos.y == 0 and pos.z == 0)

        -- only add entity if it is at valid coordinates
        if not invalidCoordinates then
            table.insert(validEntities, entity)
        end
    end

    return validEntities
end

-----------------------------------
-- func: goToEntity
-- desc: teleports the player to the given NPC
-----------------------------------
local goToEntity = function(player, entity)
    -- determine whether we need zoneId parameter
    local gotoZone = nil
    if entity:getZoneID() ~= player:getZoneID() then
        gotoZone = entity:getZoneID()
    end

    -- display message
    player:PrintToPlayer(string.format("Going to %s %s (%i).", entity:getName(), entity:getZoneName(), entity:getID()))

    -- half a second later, go.  this delay gives time for previous message to appear
    player:timer(500, function(playerArg)
        playerArg:setPos(entity:getXPos(), entity:getYPos(), entity:getZPos(), entity:getRotPos(), gotoZone)
    end)
end

function onTrigger(player, pattern, index)
    -- validate pattern
    if pattern == nil or pattern == "" then
        error(player, "You must enter an NPC name")
        return
    end

    local zone = player:getZone()
    local unfilteredEntities = zone:queryEntitiesByName(pattern)
    local entities = getValidEntities(unfilteredEntities)

    if index ~= nil and index > 0 and index <= #entities then
        goToEntity(player, entities[index])
        return
    end

    if #entities > 20 then
        player:PrintToPlayer("Too many results. Narrow your query or specify an index to go to.")
        return
    end

    if #entities == 0 then
        if #unfilteredEntities > 0 then
            player:PrintToPlayer(string.format("%s not spawned in current zone", pattern))
        else
            player:PrintToPlayer(string.format("%s not found in current zone", pattern))
        end

        return
    end

    if #entities == 1 then
        goToEntity(player, entities[1])
        return
    end

    player:PrintToPlayer("Multiple entities found. Use !gotoname <mob or npc name> <index> to choose:", xi.msg.channel.SYSTEM_3)
    for i, entity in pairs(entities) do
        player:PrintToPlayer(string.format("[%d] %s %s (%s)", i, entity:getName(), entity:getZoneName(), entity:getID()), xi.msg.channel.SYSTEM_3)
    end
end
