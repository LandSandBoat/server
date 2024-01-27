-----------------------------------
-- func: checkinstance
-- desc: Displays Progress and Stage inside instance
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local zone = player:getZone()

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local progress = instance:getProgress()
        local stage = instance:getStage()

        player:printToPlayer(string.format('Progress: %i Stage: %i', progress, stage))
    else
        player:printToPlayer('Must be in an Instanced zone')
    end
end

return commandObj
