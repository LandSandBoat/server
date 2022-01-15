---------------------------------------------------------------------------------------------------
-- func: reloadzone
-- desc: Attempt to reload specified zone lua without a restart.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "ss"
}

function onTrigger(player, zoneLua, other)
    if (zoneLua ~= nil and other == nil) then
        local String = table.concat({"scripts/zones/", zoneLua})
        package.loaded[String] = nil
        require(String)
        player:PrintToPlayer(string.format("Lua file '%s' has been reloaded.", String))
    else
        player:PrintToPlayer("Must Specify a [zone]/file lua file.")
    end
end