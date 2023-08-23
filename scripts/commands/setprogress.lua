-----------------------------------
-- func: setProgress
-- desc: changes progress inside an instance
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function onTrigger(player, progress)
    local zone = player:getZone()

    if zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local startProgress = instance:getProgress()

        instance:setProgress(progress)

        player:PrintToPlayer(string.format("Progress changed from %i to %i", startProgress, progress))
    else
        player:PrintToPlayer("Must be in an Instanced zone")
    end
end
