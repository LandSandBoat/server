-----------------------------------
-- func: setflag <flags> <target>
-- desc: set arbitrary flags for testing
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setflag <flags> (player)")
end

function onTrigger(player, flags, target)
    -- validate flags
    if flags == nil then
        error(player, "You must enter a number for the flags (hex values work).")
        return
    end

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

    -- set flags
    targ:setFlag(flags)
end
