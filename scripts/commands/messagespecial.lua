-----------------------------------
-- func: messagespecial
-- desc: Injects a message special packet.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'iiiii'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!messagespecial <message ID> (param1) (param2) (param3) (param4) (param5)')
end

commandObj.onTrigger = function(player, msgId, param1, param2, param3, param4, param5)
    -- validate msgId
    if msgId == nil then
        error(player, 'You must provide a message ID.')
        return
    end

    -- inject message special packet
    if param5 ~= nil then
        player:messageSpecial(msgId, param1, param2, param3, param4, param5)
    elseif param4 ~= nil then
        player:messageSpecial(msgId, param1, param2, param3, param4)
    elseif param3 ~= nil then
        player:messageSpecial(msgId, param1, param2, param3)
    elseif param2 ~= nil then
        player:messageSpecial(msgId, param1, param2)
    elseif param1 ~= nil then
        player:messageSpecial(msgId, param1)
    else
        player:messageSpecial(msgId)
    end
end

return commandObj
