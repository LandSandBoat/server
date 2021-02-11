-----------------------------------
-- func: makepearlsack
-- desc: Makes a pearlsack for the given linkshell
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!makepearlsack <linkshell name>")
end

function onTrigger(player, target)

    -- validate target
    if not target then
        error(player, "You must enter a linkshell name.")
        return
    end

    if player:addLinkpearl(target, false) then
        player:PrintToPlayer("Pearlsack created for \""..target.."\"!")
    else
        error(player, string.format("Unable to create pearlsack for \"%s\"!", target))
    end
end
