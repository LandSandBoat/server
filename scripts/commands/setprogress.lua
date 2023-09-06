-----------------------------------
-- func: setProgress
-- desc: changes progress inside an instance
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

commandObj.onTrigger = function(player, progress)
    local zone = player:getZone()

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local startProgress = instance:getProgress()

        instance:setProgress(progress)

        player:PrintToPlayer(string.format('Progress changed from %i to %i', startProgress, progress))
    else
        player:PrintToPlayer('Must be in an Instanced zone')
    end
end

return commandObj
