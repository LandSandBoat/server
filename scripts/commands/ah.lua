-----------------------------------
-- func: ah
-- desc: opens the Auction House menu anywhere in the world
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    player:sendMenu(3)
end

return commandObj
