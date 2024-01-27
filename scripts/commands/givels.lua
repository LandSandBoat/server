-----------------------------------
-- func: givels
-- desc: Makes a linkpearl for the given linkshell (pearlsack for gm)
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!givels <linkshell name> (target)')
end

commandObj.onTrigger = function(player, lsname, target)
    -- validate target
    if not lsname then
        error(player, 'You must enter a linkshell name.')
        return
    end

    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    if targ:addLinkpearl(lsname, false) then
        player:printToPlayer('Linkpearl created for \''..lsname..'\'!')
    else
        error(player, string.format('Unable to create linkpearl for \'%s\'!', lsname))
    end
end

return commandObj
