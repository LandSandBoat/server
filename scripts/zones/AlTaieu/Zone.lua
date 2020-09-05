-----------------------------------
--
-- Zone: AlTaieu (33)
--
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-25, -1 , -620 , 33)
    end
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY and player:getCharVar("PromathiaStatus") == 0) then
        cs=1
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 0) then
        cs=167
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1) then
        player:setCharVar("PromathiaStatus", 1)
        player:addKeyItem(tpz.ki.LIGHT_OF_ALTAIEU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_ALTAIEU)
        player:addTitle(tpz.title.SEEKER_OF_THE_LIGHT)
    elseif (csid == 167) then
        player:setCharVar("PromathiaStatus", 1)
    end
end
