---------------------------------------------------------------------------------------------------
-- func: reloadmixin
-- desc: Attempt to reload specified mixin lua without a restart.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "ss"
}

function onTrigger(player, mixinLua, other)
    if mixinLua and other then
        local String = table.concat({"scripts/mixins/", mixinLua})
        package.loaded[String] = nil
        require(String)
        player:PrintToPlayer(string.format("Lua file '%s' has been reloaded.", String))
    else
        player:PrintToPlayer("Must Specify a mixin lua file.")
    end
end