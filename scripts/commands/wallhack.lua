-----------------------------------
-- func: wallhack <optional target>
-- desc: Allows the player to walk through walls.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!wallhack (player)")
end

function onTrigger(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- toggle wallhack for target
    if targ:checkNameFlags(0x00000200) then
        targ:setFlag(0x00000200)
        player:PrintToPlayer(string.format("Toggled %s's wallhack flag OFF.", targ:getName()))
    else
        targ:setFlag(0x00000200)
        player:PrintToPlayer(string.format("Toggled %s's wallhack flag ON.", targ:getName()))
    end
end
