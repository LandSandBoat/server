-----------------------------------
-- func: messagebasic
-- desc: Injects a message basic packet.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'iii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!messagebasic <message ID> (param1) (param2)')
end

commandObj.onTrigger = function(player, msgId, param1, param2)
    -- validate msgId
    if msgId == nil then
        error(player, 'You must provide a message ID.')
        return
    end

    local target = player:getCursorTarget()
    if target == nil then
        target = player
    end

    -- inject message packet
    player:messageBasic(msgId, param1, param2, target)
end

return commandObj
