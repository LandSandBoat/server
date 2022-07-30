---------------------------------------------------------------------------------------------------
-- func: spin
-- desc: Spins a player 180 degrees (127 rad)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spin <player>")
end

function onTrigger(player, targ)
    local target = nil
    -- validate target
    if targ then
        target = GetPlayerByName(targ)
    elseif player:getCursorTarget() then
        target = player:getCursorTarget()
    else
        return error("Invalid target.")
    end

    target:setRotation(target:getRotPos() + 127)

    return player:PrintToPlayer(string.format("Hmm... let's see how much of a sussy wussy %s is!", target:getName()))
end
