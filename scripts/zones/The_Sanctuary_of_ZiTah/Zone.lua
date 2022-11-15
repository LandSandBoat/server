-----------------------------------
-- Zone: The_Sanctuary_of_ZiTah (121)
-----------------------------------
local ID = require('scripts/zones/The_Sanctuary_of_ZiTah/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    GetMobByID(ID.mob.NOBLE_MOLD):setLocalVar("pop", os.time() + math.random(43200, 57600)) -- 12 to 16 hr

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(539.901, 3.379, -580.218, 126)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
