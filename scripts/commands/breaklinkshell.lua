---------------------------------------------------------------------------------------------------
-- func: breaklinkshell
-- desc: Breaks a linkshell and all pearls/sacks
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!breaklinkshell <linkshell name>")
end

function onTrigger(player, target)

    -- validate target
    if not target then
        error(player, "You must enter a linkshell name.")
        return
    end

    if player:breakLinkshell(target) then
        player:PrintToPlayer("Linkshell named \""..target.."\" has been broken!")
    else
        error(player, string.format("Linkshell named \"%s\" not found!", target))
    end
end
