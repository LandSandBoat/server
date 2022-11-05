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
    player:PrintToPlayer("!gotonpc <npcName> (index)")
end

local removeInvalidNpcs = function(npcs)
    local validNpcs = {}
    for i, npc in pairs(npcs) do
        local pos = npc:getPos()
        local invalidCoordinates = (pos.x == 0 and pos.y == 0 and pos.z == 0)

        -- only add npc if it is at valid coordinates
        if not invalidCoordinates then
            table.insert(validNpcs, npc)
        end
    end

    return validNpcs
end

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

function onTrigger(player, npcName, index)
    -- validate npc
    if npcName == nil or npcName == "" then
        error(player, "You must enter an NPC name")
        return
    end

    -- get and filter npcs by name
    local npcs = GetNPCsByName(npcName)
    npcs = removeInvalidNpcs(npcs)

    if #npcs > 10 then
        player:PrintToPlayer("Too many results. Narrow your query.")
        return
    end

    if index ~= nil and index > 0 and index <= #npcs then
        goToNpc(player, npcs[index])
        return
    end

    if #npcs == 0 then
        player:PrintToPlayer(string.format("%s not found in any zone", npcName))
        return
    end

    if #npcs == 1 then
        goToNpc(player, npcs[1])
        return
    end

    player:PrintToPlayer("Multiple npcs found. Use !gotonpc <pattern> <index> to choose:")
    for i, npc in pairs(npcs) do
        player:PrintToPlayer(string.format("[%d]: %s %s (%s)", i, npc:getName(), npc:getZoneName(), npc:getID()))
    end
end
