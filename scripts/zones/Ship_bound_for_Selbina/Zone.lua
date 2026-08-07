-----------------------------------
-- Zone: Ship_bound_for_Selbina (220)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.randomInt(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    -- Enagakure pop mechanics.
    local enagakure = GetMobByID(ID.mob.ENAGAKURE)
    local hour      = VanadielHour()

    if
        enagakure and
        not enagakure:isSpawned() and
        (hour >= 20 or hour < 4) and
        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
        xi.quest.getVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX, 'Prog') == 4
    then
        SpawnMob(ID.mob.ENAGAKURE)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    player:startEvent(255)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, xi.zone.SELBINA)
    end
end

zoneObject.onGameHour = function(zone)
    -- Enagakure pop mechanics. It appears at night for anyone already aboard, so the
    -- check also runs here; the spawn point's window handles the despawn.
    local enagakure = GetMobByID(ID.mob.ENAGAKURE)
    local hour      = VanadielHour()

    if
        enagakure and
        not enagakure:isSpawned() and
        (hour >= 20 or hour < 4)
    then
        for _, player in pairs(zone:getPlayers()) do
            if
                player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                xi.quest.getVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX, 'Prog') == 4
            then
                SpawnMob(ID.mob.ENAGAKURE)
                break
            end
        end
    end
end

return zoneObject
