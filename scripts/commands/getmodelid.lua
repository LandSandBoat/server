-----------------------------------
-- func: !getmodel
-- desc: Prints the target modelID, animationID and animationSubID
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getmodel <target>")
end

function onTrigger(player)
    local target = player:getCursorTarget()

    if target ~= nil and target:isMob() or target:isNPC() then
        player:PrintToPlayer(string.format(
            "%s (%d): model %d, animation %d, animationSub %d",
            target:getName(),
            target:getID(),
            target:getModelId(),
            target:getAnimation(),
            target:getAnimationSub()
        ))
    else
        error(player, string.format("Target is not a mob or NPC"))
    end
end
