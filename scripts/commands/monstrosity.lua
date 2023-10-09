-----------------------------------
-- func: monstrosity
-- desc: scripts/globals/monstrosity.lua for a general overview of how Monstrosity works and is designed.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    if player:getMainJob() ~= xi.job.MON then
        player:changeJob(xi.job.MON)
    end

    player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
end

return commandObj
