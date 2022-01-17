-----------------------------------
-- func: setStage
-- desc: changes stage inside an instance
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(player, stage)
    local zone = player:getZone()

    if zone:getType() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local startStage = instance:getStage()

        instance:setStage(stage)

        player:PrintToPlayer(string.format("Stage changed from %i to %i", startStage, stage))
    else
        player:PrintToPlayer("Must be in an Instanced zone")
    end
end
