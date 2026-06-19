-----------------------------------
-- func: !raji
-- desc: Sets the players current costume to Raji.
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
        player:printToPlayer('The correct syntax is !raji on / !raji off')
        return
    end

    if onoff == 'on' then
        player:setCostume(397)
    elseif onoff == 'off' then
        player:setCostume(0)
    else
        player:printToPlayer('The correct syntax is !raji on / !raji off')
    end
end

return commandObj
