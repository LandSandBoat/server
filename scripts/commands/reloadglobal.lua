---------------------------------------------------------------------------------------------------
-- func: reloadglobal
-- desc: Attempt to reload specified global lua without a restart.
--
-- Use with caution, some files (like player.lua) can
-- possibly cause problems if you reload them using this.
-- This command expects the user to know wtf they are doing,
-- but has a default permission lv of 4 so that helpers or
-- less experienced GMs do not mistakenly misuse it.
--
-- specify "I_am_sure" without quotes to attempt to reload things that are not in \scripts\globals\
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "ss"
}

function onTrigger(player, globalLua, other)
    if (globalLua ~= nil and other == nil) then
        local String = table.concat({"scripts/globals/", globalLua})
        package.loaded[String] = nil
        require(String)
        player:PrintToPlayer(string.format("Lua file '%s' has been reloaded.", String))
    elseif (other == "I_am_sure") then
        package.loaded[globalLua] = nil
        require(globalLua)
        player:PrintToPlayer(string.format("Lua file '%s' has been reloaded.", globalLua))
    else
        player:PrintToPlayer("Must Specify a global lua file.")
    end
end
