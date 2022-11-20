-----------------------------------
-- Zone: Xarcabard (112)
-----------------------------------
local ID = require('scripts/zones/Xarcabard/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/conquest')
require('scripts/globals/keyitems')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local dynamisMask = player:getCharVar("Dynamis_Status")

    local unbridledPassionCS = player:getCharVar("unbridledPassion")

    if prevZone == xi.zone.DYNAMIS_XARCABARD then -- warp player to a correct position after dynamis
        player:setPos(569.312, -0.098, -270.158, 90)
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(158, -21, -44, 132)
    end

    if
        not player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
        player:getRank(player:getNation()) >= 6 and
        player:getMainLvl() >= xi.settings.main.DYNA_LEVEL_MIN and
        not utils.mask.getBit(dynamisMask, 0)
    then
        cs = 13
    elseif quests.rainbow.onZoneIn(player) then
        cs = 9
    elseif unbridledPassionCS == 3 then
        cs = 4
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 9 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("unbridledPassion", 4)
    elseif csid == 13 then
        player:setCharVar("Dynamis_Status", utils.mask.setBit(player:getCharVar("Dynamis_Status"), 0, true))
    end
end

return zoneObject
