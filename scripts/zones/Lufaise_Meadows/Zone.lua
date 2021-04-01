-----------------------------------
--
-- Zone: Lufaise_Meadows (24)
--
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable("realPadfoot", math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        SpawnMob(v)
    end

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-475.825, -20.461, 281.149, 11)
    end

    if (player:getCurrentMission(COP) == xi.mission.id.cop.AN_INVITATION_WEST and player:getCharVar("PromathiaStatus") == 0) then
        cs = 110
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus") == 0) then
        cs = 111
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
    local regionID = region:GetRegionID()
    if (regionID == 1 and player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 6) then
        player:startEvent(116)
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 110) then
        player:messageSpecial(ID.text.KI_STOLEN, 0, xi.ki.MYSTERIOUS_AMULET)
        player:delKeyItem(xi.ki.MYSTERIOUS_AMULET)
        player:setCharVar("PromathiaStatus", 1)
    elseif (csid == 111 and npcUtil.giveItem(player, 14657)) then
        player:setCharVar("PromathiaStatus", 1)
    elseif (csid == 116) then
        player:setCharVar("PromathiaStatus", 7)
        player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
    end
end

return zone_object
