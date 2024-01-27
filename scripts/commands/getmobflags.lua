-----------------------------------
-- func: getmobflags <optional MobID>
-- desc: Used to get a mob's entity flags for testing.
--       MUST either target a mob first or else specify a Mob ID.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getmobflags (mob ID)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if not target then
        targ = player:getCursorTarget()
        if not targ or not targ:isMob() then
            error(player, 'You must either supply a mob ID or target a mob.')
            return
        end
    else
        targ = GetMobByID(target)
        if not targ then
            error(player, 'Invalid mob ID.')
            return
        end
    end

    -- set flags
    local flags = targ:getMobFlags()
    local hex = '0x' .. string.format('%08x', flags)
    player:printToPlayer(string.format('%s\'s flags: %s (%u)', targ:getName(), hex, flags))
end

return commandObj
