-----------------------------------
-- func: setStage
-- desc: changes stage inside an instance
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function onTrigger(player, stage)
    local zone = player:getZone()

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local startStage = instance:getStage()

        instance:setStage(stage)

        player:PrintToPlayer(string.format("Stage changed from %i to %i", startStage, stage))
    else
        player:PrintToPlayer("Must be in an Instanced zone")
    end
end
