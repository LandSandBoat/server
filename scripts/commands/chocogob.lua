-----------------------------------
-- func: !chocogob
-- desc: Sets the players current costume to a goblin riding a chocobo.
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
        player:printToPlayer('The correct syntax is !chocogob on / !chocogob off')
        return
    end

    if onoff == 'on' then
        player:setCostume(1249)
    elseif onoff == 'off' then
        player:setCostume(0)
    else
        player:printToPlayer('The correct syntax is !chocogob on / !chocogob off')
    end
end

return commandObj
