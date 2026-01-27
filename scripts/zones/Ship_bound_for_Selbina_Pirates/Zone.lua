-----------------------------------
-- Zone: Ship bound for Selbina Pirates (227)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
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
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    -- Enagakure pop mechanics.
    local enagakure = GetMobByID(ID.mob.ENAGAKURE)
    local hour      = VanadielHour()

    if
        enagakure and
        not enagakure:isSpawned() and
        VanadielUniqueDay() > enagakure:getLocalVar('despawnDay') and
        hour < 4 and
        hour >= 20 and
        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
        player:getCharVar('Enagakure_Killed') == 0
    then
        SpawnMob(ID.mob.ENAGAKURE)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- don't take action on pirate ship transport departure
    if prevZoneId > 0 then
        player:startEvent(255)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, xi.zone.SELBINA)
    end
end

zoneObject.onGameHour = function(zone)
    -- Enagakure pop mechanics.
    local enagakure = GetMobByID(ID.mob.ENAGAKURE)
    local hour      = VanadielHour()

    if enagakure then
        if enagakure:isSpawned() then
            if
                hour >= 4 and hour < 20 and -- Not night-time.
                not enagakure:isEngaged()   -- Not engaged.
            then
                DespawnMob(ID.mob.ENAGAKURE)
            end
        else
            if
                hour < 4 and hour >= 20 and                               -- Night-time.
                VanadielUniqueDay() > enagakure:getLocalVar('despawnDay') -- Can spawn today.
            then
                for _, player in pairs(zone:getPlayers()) do
                    if
                        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                        player:getCharVar('Enagakure_Killed') == 0
                    then
                        SpawnMob(ID.mob.ENAGAKURE)
                        break
                    end
                end
            end
        end
    end
end

return zoneObject
