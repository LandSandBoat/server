-----------------------------------
-- func: setProgress
-- desc: changes progress inside an instance
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

commandObj.onTrigger = function(player, progress)
    local zone = player:getZone()
    if not zone then
        return
    end

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        if not instance then
            return
        end

        local startProgress = instance:getProgress()

        instance:setProgress(progress)

        player:printToPlayer(string.format('Progress changed from %i to %i', startProgress, progress))
    else
        player:printToPlayer('Must be in an Instanced zone')
    end
end

return commandObj
