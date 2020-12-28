---------------------------------------------------------------------------------------------------
-- func: release
-- desc: Releases the player from current events.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!release {name}")
end

function onTrigger(player, name)
    local target
    if name == nil then
        target = player
    else
        target = tpz.core.getPlayerByName(name)
        if target == nil then
            error(player, string.format("Player named '%s' not found!", name))
            return
        end
    end

    target:release()
end
