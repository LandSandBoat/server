-----------------------------------
-- func: reloadglobal
-- desc: Attempt to reload specified global lua without a restart.
--
-- Use with caution, some files (like player.lua) can
-- possibly cause problems if you reload them using this.
-- This command expects the user to know wtf they are doing,
-- but has a default permission lv of 4 so that helpers or
-- less experienced GMs do not mistakenly misuse it.
--
-- specify 'I_am_sure' without quotes to attempt to reload things that are not in \scripts\globals\
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 'ss'
}

commandObj.onTrigger = function(player, globalLua, other)
    if globalLua ~= nil and other == nil then
        local pathString = table.concat({ 'scripts/globals/', globalLua })
        package.loaded[pathString] = nil
        require(pathString)
        player:printToPlayer(string.format('Lua file \'%s\' has been reloaded.', pathString))
    elseif other == 'I_am_sure' then
        package.loaded[globalLua] = nil
        require(globalLua)
        player:printToPlayer(string.format('Lua file \'%s\' has been reloaded.', globalLua))
    else
        player:printToPlayer('Must Specify a global lua file.')
    end
end

return commandObj
