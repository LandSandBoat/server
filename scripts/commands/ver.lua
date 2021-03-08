-----------------------------------
-- func: ver
-- desc: prints Ixion version to player
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player, target)
    local version = GetServerVersion()
    local branch = "unstable"
    if version.branch == 1 then
        branch = "stable"
    end
    player:PrintToPlayer(string.format("version %s%02s_%s (%s)",version.major,version.minor,version.rev,branch))
end
