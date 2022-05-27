---------------------------------------------------------------------------------------------------
-- func: getenmity
-- desc: prints the target mob's current CE and VE towards you
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
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

    if targ == nil or targ:isMob() == false then
        error(player, "you must select a target monster with the cursor first")
        return
    end

    player:PrintToPlayer(string.format("your enmity against %s is ... CE = %u ... VE = %u", targ:getName(), targ:getCE(player), targ:getVE(player)))

end
