-----------------------------------
-- func: setmobflags <flags> <optional MobID>
-- desc: Used to manipulate a mob's nameflags for testing.
--       MUST either target a mob first or else specify a Mob ID.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmobflags <flags> {mob ID}")
end

function onTrigger(player, flags, target)
    -- validate flags
    if flags ~= nil and tonumber(flags) ~= nil then
        flags = tonumber(flags)
    else
        error(player, "You must supply a flags value.")
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isMob()) then
            error(player, "You must either supply a mob ID or target a mob.")
            return
        end
    else
        targ = GetMobByID(target)
        if targ == nil then
            error(player, "Invalid mob ID.")
            return
        end
    end

    -- set flags
    player:setMobFlags(flags, targ:getID())
    local hex = "0x" .. string.format("%08x", flags)
    player:PrintToPlayer( string.format("Set %s %i flags to %s (%i).", targ:getName(), targ:getID(), hex, flags) )
end
