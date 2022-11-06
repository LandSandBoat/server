-----------------------------------
-- func: gotonpc
-- desc: Go to given npc by name
-----------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!gotonpc <npcname> (index)")
end

-----------------------------------
-- func: getValidNPCs
-- desc: given a list of entities, returns the ones that have valid coordinates and
-- of type NPC
-----------------------------------
local getValidNPCs = function(entities)
    local validEntities = {}
    for i, entity in pairs(entities) do
        if entity:getObjType() == xi.objType.NPC then
            local pos = entity:getPos()
            local invalidCoordinates = (pos.x == 0 and pos.y == 0 and pos.z == 0)

            -- only add npc if it is at valid coordinates
            if not invalidCoordinates then
                table.insert(validEntities, entity)
            end
        end
    end

    return validEntities
end

-----------------------------------
-- func: goToNpc
-- desc: teleports the player to the given NPC
-----------------------------------
local goToNpc = function(player, npc)
    -- determine whether we need zoneId parameter
    local gotoZone = nil
    if npc:getZoneID() ~= player:getZoneID() then
        gotoZone = npc:getZoneID()
    end

    -- display message
    player:PrintToPlayer(string.format("Going to %s %s (%i).", npc:getName(), npc:getZoneName(), npc:getID()))

    -- half a second later, go.  this delay gives time for previous message to appear
    player:timer(500, function(playerArg)
        playerArg:setPos(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos(), gotoZone)
    end)
end

function onTrigger(player, pattern, index)
    -- validate npc
    if pattern == nil or pattern == "" then
        error(player, "You must enter an NPC name")
        return
    end

    local zone = player:getZone()
    local entities = zone:queryEntitiesByName(pattern)
    local npcs = getValidNPCs(entities)

    if #npcs > 10 then
        player:PrintToPlayer("Too many results. Narrow your query.")
        return
    end

    if index ~= nil and index > 0 and index <= #npcs then
        goToNpc(player, npcs[index])
        return
    end

    if #npcs == 0 then
        player:PrintToPlayer(string.format("%s not found in current zone", pattern))
        return
    end

    if #npcs == 1 then
        goToNpc(player, npcs[1])
        return
    end

    player:PrintToPlayer("Multiple npcs found. Use !gotonpc <npcname> <index> to choose:")
    for i, npc in pairs(npcs) do
        player:PrintToPlayer(string.format("[%d]: %s %s (%s)", i, npc:getName(), npc:getZoneName(), npc:getID()))
    end
end
