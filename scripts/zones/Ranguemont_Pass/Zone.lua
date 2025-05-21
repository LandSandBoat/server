-----------------------------------
-- Zone: Ranguemont Pass (166)
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- pick a random Taisaijin PH and set its do not disturb time
    local phIndex = math.random(1, 3)
    local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])

    if ph then
        ph:setLocalVar('timeToGrow', os.time() + math.random(86400, 259200)) -- 1 to 3 days
        ph:setLocalVar('phIndex', phIndex)
    end
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
