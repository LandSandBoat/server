local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!mount <mount ID> (player)')
end

commandObj.onTrigger = function(player, mount, target)
    -- Default to Chocobo (0)
    if mount == nil then
        mount = 0
    end

    -- validate mount
    mount = tonumber(mount) or xi.mount[string.upper(mount)]
    if mount == nil or mount < 0 or mount >= xi.mount.MOUNT_MAX then
        error(player, 'Invalid mount ID.')
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    targ:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, mount, 0, 0, true)
end

return commandObj
