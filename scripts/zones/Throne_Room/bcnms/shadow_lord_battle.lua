-----------------------------------
-- Area: Throne Room
-- Name: Mission 5-2
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldInitialise(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(player:getNation(), tpz.mission.id.nation.SHADOW_LORD) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 and player:getCurrentMission(player:getNation()) == tpz.mission.id.nation.SHADOW_LORD and player:getCharVar("MissionStatus") == 3 then
        if player:getCurrentMission(ZILART) ~= tpz.mission.id.zilart.THE_NEW_FRONTIER and not player:hasCompletedMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_NEW_FRONTIER) then
            -- Don't add missions we already completed. Players who change nation will hit this.
            player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_NEW_FRONTIER)
        end
        player:startEvent(7)
    elseif csid == 7 then
        player:addKeyItem(tpz.ki.SHADOW_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHADOW_FRAGMENT)
        player:setCharVar("MissionStatus", 4)
        player:setPos(378, -12, -20, 125, 161)
    end
end
