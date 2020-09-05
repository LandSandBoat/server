-----------------------------------
--
-- Zone: Talacca_Cove (57)
--
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/titles")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.TESTING_THE_WATERS and player:getCharVar("AhtUrganStatus") == 1) then
        player:setPos(-88.879, -7.318, -109.233, 173)
        cs = 106
    elseif (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(64.007, -9.281, -99.988, 88)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 106) then
        player:completeMission(TOAU, tpz.mission.id.toau.TESTING_THE_WATERS)
        player:delKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)
        player:addKeyItem(tpz.ki.PERCIPIENT_EYE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PERCIPIENT_EYE)
        player:setTitle(tpz.title.TREASURE_TROVE_TENDER)
        player:setCharVar("AhtUrganStatus", 0)
        player:addMission(TOAU, tpz.mission.id.toau.LEGACY_OF_THE_LOST)
    end
end
