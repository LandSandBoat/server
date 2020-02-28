require("scripts/globals/status")

cmdprops =
{
    permission = 0,
    parameters = "sss"
};

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mount <mount ID> {player}")
end

function onTrigger(player, mount, target)

    -- validate mount
    if (mount == nil) then
        error(player, "You must supply a mount ID or name.")
        return
    end

    mount = tonumber(mount) or tpz.mount[string.upper(mount)]
    if (mount == nil or mount < 0 or mount > 26) then
        error(player, "Invalid mount ID.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    targ:addStatusEffectEx(tpz.effect.MOUNTED, tpz.effect.MOUNTED, mount, 0, 1800, true)
end