local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    if player:getCharVar('MONSTROSITY_START') == 1 then
        player:setCharVar('MONSTROSITY_START', 0)
    else
        player:setCharVar('MONSTROSITY_START', 1)
    end

    player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
end

return commandObj
