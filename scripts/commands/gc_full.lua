---------------------------------------------------------------------------------------------------
-- func: gc_full
-- desc: Tell Lua to run a full garbage collection
-- note: For testing only (GM level 5)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 5,
    parameters = ""
}

function onTrigger(player)
    GarbageCollectFull()
end
