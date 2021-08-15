---------------------------------------------------------------------------------------------------
-- func: addabytime
-- desc: Adds an amount of time to the given target. If no target then to the current player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addabytime <minutes> {player}")
end

function onTrigger(player, minutes, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- target must be in dynamis
    local effect = targ:getStatusEffect(xi.effect.VISITANT)
    if not effect then
        error(player, string.format("%s is not in Abyssea.", targ:getName()))
        return
    end

    -- validate amount
    if minutes == nil or minutes < 1 then
        error(player, "Invalid number of minutes.")
        return
    end

    -- add time
    local zoneId = targ:getZoneID()
    local ID = zones[zoneId]
    local old_duration = effect:getDuration()
	player:PrintToPlayer(old_duration)
    effect:setDuration((old_duration + (minutes * 60)) * 1000)
    --targ:messageSpecial(ID.text.ABYSSEA_TIME_EXTEND, minutes)
end
