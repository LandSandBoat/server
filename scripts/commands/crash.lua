-----------------------------------
-- func: crash
-- desc: force the server process to crash
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 7,
    parameters = ""
}

commandObj.onTrigger = function(player)
    ForceCrash()
end

return commandObj
