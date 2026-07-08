-----------------------------------
-- func: sleep
-- desc: inject an artificial delay of 1 second (FOR LOCAL PERFORMANCE TESTING ONLY)
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = ''
}

commandObj.onTrigger = function()
    -- THIS IS A FULLY MAIN THREAD BLOCKING SLEEP
    -- DO NOT USE THIS IN REGULAR CODE
    -- THIS IS ONLY FOR TESTING
    sleep(1)
end

return commandObj
