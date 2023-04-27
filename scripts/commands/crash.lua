-----------------------------------
-- func: crash
-- desc: force the server process to crash
-----------------------------------

cmdprops =
{
    permission = 7,
    parameters = ""
}

function onTrigger(player)
    ForceCrash()
end
