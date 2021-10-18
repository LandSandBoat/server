-----------------------------------
-- func: setInstance
-- desc: changes progress and stage inside instance
-- note: changing stage is optional
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ii"
}

function onTrigger(player, progress, stage)
    local zone = player:getZone()

    if zone:getType() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local startProgress = instance:getProgress()
        local startStage = instance:getStage()

        instance:setProgress(progress)

        if stage ~= nil then
            instance:setStage(stage)
            player:PrintToPlayer(string.format("Progress changed from %i to %i", startProgress, progress))
            player:PrintToPlayer(string.format("Stage changed from %i to %i", startStage, stage))
        else
            player:PrintToPlayer(string.format("Progress changed from %i to %i", startProgress, progress))
        end
    else
        player:PrintToPlayer("Must be in an Instanced zone")
    end
end
