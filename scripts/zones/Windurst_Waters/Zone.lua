-----------------------------------
-- Zone: Windurst_Waters (238)
-----------------------------------
local ID = require('scripts/zones/Windurst_Waters/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Used for Windurst Mission 1-3
    zone:registerTriggerArea(1, 23, -12, -208, 31, -8, -197)

    applyHalloweenNpcCostumes(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = { 531, -1, xi.cutscenes.params.NO_OTHER_ENTITY }
        end
        player:setPos(-40, -5, 80, 64)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) + 157
        player:setPos(position, -5, -62, 192)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 531 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end
end

return zoneObject
