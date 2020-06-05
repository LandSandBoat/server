---------------------------------------------------------------------------------------------------
-- func: timeoffset
-- desc: Sets the custom time offset of the CVanaTime instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!timeoffset <offset>")
end

function onTrigger(player, offset)

    -- validate offset
    if (offset == nil) then
        error(player, "Invalid offset.")
        return
    end

    -- time offset
    local result = SetVanadielTimeOffset( offset )
    if (result == nil) then
        error(player, "Time offset was not successful.")
        return
    end
end
