-----------------------------------
-- func: inject
-- desc: Injects the given packet data.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!inject <packet>')
end

commandObj.onTrigger = function(player, packet)
    -- validate packet
    if packet == nil then
        error(player, 'You must enter a packet file name.')
        return
    end

    -- inject packet
    player:injectPacket(packet)
end

return commandObj
