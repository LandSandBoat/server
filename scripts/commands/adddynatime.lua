-----------------------------------
-- func: adddynatime
-- desc: Adds an amount of time to the given target. If no target then to the current player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!adddynatime <minutes> (player)")
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
    local effect = targ:getStatusEffect(xi.effect.DYNAMIS)
    if not effect then
        error(player, string.format("%s is not in Dynamis.", targ:getName()))
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
    local oldDuration = effect:getDuration()
    effect:setDuration((oldDuration + (minutes * 60)) * 1000)
    targ:setLocalVar("dynamis_lasttimeupdate", effect:getTimeRemaining() / 1000)
    targ:messageSpecial(ID.text.DYNAMIS_TIME_EXTEND, minutes)
end
