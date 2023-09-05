-----------------------------------
-- func: gc_step
-- desc: Tell Lua to run a garbage collection step
-- note: For testing only (GM level 5)
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = ''
}

commandObj.onTrigger = function(player)
    GarbageCollectStep()
end

return commandObj
