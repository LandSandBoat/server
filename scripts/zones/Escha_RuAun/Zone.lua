-----------------------------------
-- Zone: Escha_RuAun (289)
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    GetNPCByID(ID.npc.QM_GENBU):setStatus(xi.status.DISAPPEAR)
    GetNPCByID(ID.npc.QM_SUZAKU):setStatus(xi.status.DISAPPEAR)
    GetNPCByID(ID.npc.QM_SEIRYU):setStatus(xi.status.DISAPPEAR)
    GetNPCByID(ID.npc.QM_BYAKKO):setStatus(xi.status.DISAPPEAR)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-0.371, -34.277, -466.98, 187)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
