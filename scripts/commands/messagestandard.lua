-----------------------------------
-- func: messagestandard
-- desc: Injects a standard message packet.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!messagestandard <message ID>')
end

commandObj.onTrigger = function(player, msgId)
    -- validate msgId
    if msgId == nil then
        error(player, 'You must provide a message ID.')
        return
    end

    -- inject message packet
    player:messageBasic(msgId)
end

return commandObj
