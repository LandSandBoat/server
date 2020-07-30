require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mount <mount ID> {player}")
end

function onTrigger(player, mount, target)

    -- Default to Chocobo (0)
    if (mount == nil) then
        mount = 0
    end

    -- validate mount
    mount = tonumber(mount) or tpz.mount[string.upper(mount)]
    if (mount == nil or mount < 0 or mount > 27) then
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

    targ:addStatusEffectEx(tpz.effect.MOUNTED, tpz.effect.MOUNTED, mount, 0, 0, true)
end