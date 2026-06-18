-----------------------------------
-- func: !shantotto
-- desc: Sets the players current costume to Shantotto v2.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

commandObj.onTrigger = function(player, onoff)
    if onoff == nil then
        player:printToPlayer('The correct syntax is !shantotto on / !shantotto off')
        return
    end

    if onoff == 'on' then
        player:setCostume(3110)
    elseif onoff == 'off' then
        player:setCostume(0)
    else
        player:printToPlayer('The correct syntax is !shantotto on / !shantotto off')
    end
end

return commandObj
