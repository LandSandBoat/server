-----------------------------------
-- func: checkinstance
-- desc: Displays Progress and Stage inside instance
-----------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local progress = instance:getProgress()
        local stage = instance:getStage()

        player:PrintToPlayer(string.format("Progress: %i Stage: %i", progress, stage))
    else
        player:PrintToPlayer("Must be in an Instanced zone")
    end
end
