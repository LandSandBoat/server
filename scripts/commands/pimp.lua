-----------------------------------
-- func: !shantotto
-- desc: Sets the players current costume to the purple RDM.
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
        player:printToPlayer('The correct syntax is !pimp on / !pimp off')
        return
    end

    if onoff == 'on' then
        player:setCostume(2277)
    elseif onoff == 'off' then
        player:setCostume(0)
    else
        player:printToPlayer('The correct syntax is !pimp on / !pimp off')
    end
end

return commandObj
