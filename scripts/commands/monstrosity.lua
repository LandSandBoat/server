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
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        player:printToPlayer('Setting main.ENABLE_MONSTROSITY is not enabled.')
        return
    end

    if player:getMainJob() ~= xi.job.MON then
        local pos = player:getPos()
        player:setMonstrosityEntryData(pos.x, pos.y, pos.z, pos.rot, player:getZoneID(), player:getMainJob(), player:getSubJob())
        player:changeJob(xi.job.MON)
    else
        local data = player:getMonstrosityData()
        player:changeJob(data.entry_mjob)
        player:changesJob(data.entry_sjob)
    end

    player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
end

return commandObj
