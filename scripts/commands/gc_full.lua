-----------------------------------
-- func: gc_full
-- desc: Tell Lua to run a full garbage collection
-- note: For testing only (GM level 5)
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = ''
}

commandObj.onTrigger = function(player)
    GarbageCollectFull()
end

return commandObj
