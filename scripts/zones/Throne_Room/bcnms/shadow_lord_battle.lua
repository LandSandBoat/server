-----------------------------------
-- Area: Throne Room
-- Name: Mission 5-2
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(player:getNation(), xi.mission.id.nation.SHADOW_LORD) and 1 or 0

        if player:getCurrentMission(player:getNation()) == xi.mission.id.SHADOW_LORD then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    local pNation = player:getNation()

    -- This code to be deprecated after converting Bastok and Windurst M5-2 to Interaction Framework
    if pNation ~= xi.nation.SANDORIA then
        if csid == 32001 and player:getCurrentMission(pNation) == xi.mission.id.nation.SHADOW_LORD and player:getMissionStatus(pNation) == 3 then
            if player:getCurrentMission(ZILART) ~= xi.mission.id.zilart.THE_NEW_FRONTIER and not player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER) then
                -- Don't add missions we already completed. Players who change nation will hit this.
                player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
            end
            player:startEvent(7)
        elseif csid == 7 then
            player:addKeyItem(xi.ki.SHADOW_FRAGMENT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SHADOW_FRAGMENT)
            player:setMissionStatus(player:getNation(), 4)
            player:setPos(378, -12, -20, 125, 161)
        end
    end
end

return battlefield_object
