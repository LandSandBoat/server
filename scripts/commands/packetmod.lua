-----------------------------------
-- func: packetmod
-- desc: Adds a modifier for S->C packets
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'ssss'
}

local function error(player, msg)
    player:printToPlayer(msg
        .. '\n!packetmod (operation) (packet id) (offset) (value)'
        .. '\nOperations: add / del / clear / print')
end

commandObj.onTrigger = function(player, operation, packetId, offset, value)
    if
        operation == nil or
        operation == '' or
        tonumber(operation) ~= nil
    then
        error(player, 'Usage:')
        return
    end

    if operation == 'add' then
        player:addPacketMod(tonumber(packetId), tonumber(offset), tonumber(value))
    elseif operation == 'del' then
        -- TODO
    elseif operation == 'clear' then
        player:clearPacketMods()
    else
        -- TODO: Print list of mods
    end
end

return commandObj
