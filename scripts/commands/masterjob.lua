-----------------------------------
-- func: masterjob
-- desc: Masters the player's current job
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!masterjob <player>')
end

commandObj.onTrigger = function(player, target)
    local targ
    if target and target ~= '' then
        targ = GetPlayerByName(target)
    else
        targ = player
    end

    if not targ then
        error(player, string.format('Unable to find player named "%s"', target))
        return
    end

    targ:masterJob()
    player:PrintToPlayer(string.format('Mastered %s\'s main job!', targ:getName()))
end

return commandObj
