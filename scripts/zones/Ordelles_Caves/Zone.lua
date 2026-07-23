-----------------------------------
-- Zone: Ordelles Caves (193)
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-76.839, -1.696, 659.969, 122)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local qmRSE = GetNPCByID(ID.npc.QM_RSE)
    if not qmRSE then
        return
    end

    local currentRSELocation = VanadielRSELocation()
    local rseEventActive     = qmRSE:getLocalVar('rseEventActive')

    if currentRSELocation ~= 0 then
        qmRSE:setLocalVar('rseEventActive', 0)
        qmRSE:setStatus(xi.status.DISAPPEAR)
        return
    end

    if rseEventActive == 0 then
        qmRSE:setLocalVar('rseEventActive', 1)
        qmRSE:setStatus(xi.status.NORMAL)
    end
end

return zoneObject
