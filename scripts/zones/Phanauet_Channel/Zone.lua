-----------------------------------
-- Zone: Phanauet_Channel
-----------------------------------
local ID = zones[xi.zone.PHANAUET_CHANNEL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneTick = function(zone)
    xi.barge.onZoneTick(zone)

    -- Stubborn Dredvodd has a chance to appear at any point during the barge ride once its 21-24 hour window has elapsed.
    -- The cooldown is set when it spawns (see the mob script), so a pop nobody sticks around to kill still burns the window.
    local dredvodd = GetMobByID(ID.mob.STUBBORN_DREDVODD)
    if not dredvodd then
        return
    end

    if dredvodd:isSpawned() then
        return
    end

    if GetSystemTime() < dredvodd:getLocalVar('cooldown') then
        return
    end

    -- He only rides the South Landing -> North Landing barge, which is the active vessel in the channel from 10:10 to 16:00 Vana'diel time.
    -- Times below let him spawn only when that barge is active.
    local vanaMinutes = VanadielHour() * 60 + VanadielMinute()
    if
        vanaMinutes < utils.timeStringToMinutes('10:30') or
        vanaMinutes >= utils.timeStringToMinutes('15:50')
    then
        return
    end

    -- Per-tick chance so the appearance is spread randomly across the ride.
    if math.randomInt(1, 100) <= 5 then
        SpawnMob(ID.mob.STUBBORN_DREDVODD)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    xi.barge.onZoneIn(player)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.randomInt(-2, 2) + 0.15
        player:setPos(position, -2.000, -1.000, 190)
    end

    -- Each ambient mob has a chance to ride this barge rather than always being present, matching retail captures.
    -- Rolled once per trip, guarded on a zone var so a full boat does not roll once per passenger.
    local zone        = player:getZone(true)
    local currentTime = GetSystemTime()
    if zone and currentTime >= zone:getLocalVar('[barge]mobRoll') then
        zone:setLocalVar('[barge]mobRoll', currentTime + 20)

        for _, mobId in ipairs({ ID.mob.GIANT_PUGIL, ID.mob.FLYTRAP[1], ID.mob.FLYTRAP[2], ID.mob.OOZE }) do
            local bargeMob = GetMobByID(mobId)
            if bargeMob and not bargeMob:isSpawned() and math.randomInt(1, 100) <= 40 then
                SpawnMob(mobId)
            end
        end
    end

    -- Early return: Vodyanoi doesn't exist.
    local vodyanoi = GetMobByID(ID.mob.VODYANOI)
    if not vodyanoi then
        return cs
    end

    -- Early return: Vodyanoi can't pop yet.
    if currentTime < vodyanoi:getLocalVar('zoneWindow') then
        return cs
    end

    -- Block multiple Vodyanoi spawn chance rolls per barge ride.
    vodyanoi:setLocalVar('zoneWindow', currentTime + 20)

    -- Vodyanoi rides either barge that leaves during the night, one roll each.
    -- The cooldown is set when he spawns (see the mob script), so a pop nobody kills still burns it.
    local vanadielHour = VanadielHour()
    if
        (vanadielHour >= 20 or vanadielHour < 4) and
        currentTime > vodyanoi:getLocalVar('respawn') and
        math.randomInt(1, 100) <= 20
    then
        vodyanoi:setRespawnTime(math.randomInt(120, 180)) -- 2 to 3 minutes into the ride.
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- TODO: Only seen event 0 in captures but used to be 100 here. Both events have the exact same code.
    -- This might be used by SE to differentiate where to send the player?
    player:startEvent(0)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 0 then
        player:setPos(0, 0, 0, 0, xi.zone.CARPENTERS_LANDING)
    end
end

return zoneObject
