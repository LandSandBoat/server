-----------------------------------
-- func: setStage
-- desc: changes stage inside an instance
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

commandObj.onTrigger = function(player, stage)
    local zone = player:getZone()
    if not zone then
        return
    end

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        if not instance then
            return
        end

        local startStage = instance:getStage()

        instance:setStage(stage)

        player:printToPlayer(string.format('Stage changed from %i to %i', startStage, stage))
    else
        player:printToPlayer('Must be in an Instanced zone')
    end
end

return commandObj
