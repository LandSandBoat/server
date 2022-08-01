-----------------------------------
-- func: build
-- desc: Print the server's current build information
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player, target)
    player:PrintToPlayer(BuildString())
end
