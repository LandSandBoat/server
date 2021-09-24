-----------------------------------
-- func: crash
-- desc: force the server process to crash
-----------------------------------

cmdprops =
{
    permission = 5,
    parameters = ""
}

function onTrigger(player)
    ForceCrash()
end
