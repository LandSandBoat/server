-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Pore-Ohre
-- Involved In Mission: The Heart of the Matter
-- !pos 261 -17 -458 116
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- Check if we are on Windurst Mission 1-2
    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HEART_OF_THE_MATTER) then
        missionStatus = player:getMissionStatus(player:getNation())
        if (missionStatus == 1) then
            player:startEvent(46)
        elseif (missionStatus == 2) then
            player:startEvent(47)
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 46) then
        player:setMissionStatus(player:getNation(), 2)
        player:addKeyItem(xi.ki.SOUTHEASTERN_STAR_CHARM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SOUTHEASTERN_STAR_CHARM)
    end

end

return entity
