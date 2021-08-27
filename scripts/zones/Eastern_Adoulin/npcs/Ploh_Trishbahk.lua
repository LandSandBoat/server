-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Ploh Trishbahk
-- Type: Palace Guard
-- !pos 100.580 -40.150 -63.830 257
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local meetingOfTheMinds = player:getCurrentMission(SOA) == xi.mission.id.soa.MEETING_OF_THE_MINDS
    local dinnerTime = VanadielHour() >= 15 and VanadielHour() <= 22

    if meetingOfTheMinds then
        player:startEvent(dinnerTime and 1500 or 1501)
    else
        player:startEvent(563)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1500 then
        player:delKeyItem(xi.ki.DINNER_INVITATION)

        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.MEETING_OF_THE_MINDS)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELA_APPEARS_AGAIN)
    end
end

return entity
