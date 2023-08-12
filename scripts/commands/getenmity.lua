---------------------------------------------------------------------------------------------------
-- func: getenmity
-- desc: prints the target mob's current CE and VE towards you
---------------------------------------------------------------------------------------------------
cmdprops =
{
    permission = 2,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getenmity")
end

function onTrigger(player)
    local targ = player:getCursorTarget()

    if not targ or not targ:isMob() then
        error(player, "You must select a target monster with the cursor first.")
        return
    end

    player:PrintToPlayer(string.format("Your enmity against %s is ... CE = %u ... VE = %u", targ:getName(), targ:getCE(player), targ:getVE(player)))
end
