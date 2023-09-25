-----------------------------------
-- func: packetmod
-- desc: Adds a modifier for S->C packets
-----------------------------------

cmdprops =
{
    permission = 5,
    parameters = "ssss"
}

function error(player, msg)
    player:PrintToPlayer(msg
        .. "\n!packetmod (operation) (packet id) (offset) (value)"
        .. "\nOperations: add / del / clear / print")
end

function onTrigger(player, operation, packetId, offset, value)
    if
        operation == nil or
        operation == "" or
        tonumber(operation) ~= nil
    then
        error(player, "Usage:")
        return
    end

    if operation == "add" then
        player:addPacketMod(tonumber(packetId), tonumber(offset), tonumber(value))
    elseif operation == "del" then
        -- TODO
    elseif operation == "clear" then
        player:clearPacketMods()
    else
        -- TODO: Print list of mods
    end
end
