-----------------------------------
-- Zone: Ranguemont Pass (166)
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Pick a random Taisaijin PH and set its do not disturb time
    local offset      = math.randomInt(1, 3)
    local taisaijinPH = GetMobByID(ID.mob.TAISAIJIN - offset)
    if not taisaijinPH then
        return
    end

    taisaijinPH:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(86400, 259200)) -- 1 to 3 days
    taisaijinPH:setLocalVar('phIndex', offset)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(302.778, -68.131, 257.759, 137)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
