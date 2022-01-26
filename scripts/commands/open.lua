---------------------------------------------------------------------------------------------------
-- func: open <time>
-- desc: Forces a door to open
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!open <time>")
end

function onTrigger(player, open_time, target)
    -- validate target
    local targ = player:getCursorTarget()
    if targ == nil then
        error(player, "A door NPC must be selected.")
        return
    end

    targ:openDoor(open_time)
end