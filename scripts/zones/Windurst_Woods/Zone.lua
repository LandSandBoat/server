-----------------------------------
-- Zone: Windurst_Woods (241)
-----------------------------------
local ID = require('scripts/zones/Windurst_Woods/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/conquest')
require('scripts/globals/settings')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    applyHalloweenNpcCostumes(zone:getID())
    xi.chocobo.initZone(zone)
    xi.conquest.toggleRegionalNPCs(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 367
        end

        player:setPos(0, 0, -50, 0)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 37
        player:setPos(-138, -10, position, 0)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 367 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end
end

return zone_object
