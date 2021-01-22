-----------------------------------
-- Temple of Uggalepih
-- Balga's Dais Mission Battlefield
-----------------------------------
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addTitle(tpz.title.BEARER_OF_THE_WISEWOMANS_HOPE)
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH then
            player:startEvent(7)
        end
    elseif csid == 7 then
        player:startEvent(8)
    elseif csid == 8 and player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH then
        player:delKeyItem(tpz.ki.SACRIFICIAL_CHAMBER_KEY)
        player:addKeyItem(tpz.ki.DARK_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_FRAGMENT)
        player:completeMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
        player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE)
    end
end

return battlefield_object
