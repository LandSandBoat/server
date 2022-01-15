---------------------------------------------------------------------------------------------------
-- func: reloadmobfamily
-- desc: Attempt to reload specified mobfamily lua without a restart.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "ss"
}

function onTrigger(player, mobfamilyLua, other)
    if (mobfamilyLua ~= nil and other == nil) then
        local String = table.concat({"scripts/mobfamilies/", mobfamilyLua})
        package.loaded[String] = nil
        require(String)
        player:PrintToPlayer(string.format("Lua file '%s' has been reloaded.", String))
    else
        player:PrintToPlayer("Must Specify a mob family lua file.")
    end
end