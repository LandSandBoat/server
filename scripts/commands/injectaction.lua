---------------------------------------------------------------------------------------------------
-- func: injectaction
-- desc: Injects an action packet with the specified action and animation id.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "iiiii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!injectaction <action ID> <animation ID> {speceffect} {reaction} {message}")
end

function onTrigger(player, actionId, animationId, speceffect, reaction, message)
    -- validate actionId
    if (actionId == nil) then
        error(player, "You must provide an action ID.")
        return
    end

    -- validate animationId
    if (animationId == nil) then
        error(player, "You must provide an animation ID.")
        return
    end

    if (message == nil) then
        message = 185 -- Default message
    end

    -- inject action packet
    player:injectActionPacket(actionId, animationId, speceffect, reaction, message)
end
