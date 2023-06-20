-----------------------------------
-- Those Who Lurk in Shadows (III)
-- Qu'Bia Arena mission battlefield
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if player:hasKeyItem(xi.ki.MARK_OF_SEED) then
        player:delKeyItem(xi.ki.MARK_OF_SEED)
    end

    if leavecode == xi.battlefield.leaveCode.WON then
        player:addExp(700)
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(xi.mission.log_id.ACP) ~= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III then
            player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)
            player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
        end

        if
            not player:hasKeyItem(xi.ki.IVORY_KEY) and
            player:getCurrentMission(xi.mission.log_id.ACP) >= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III
        then
            player:setCharVar("LastIvoryKey", getMidnight())
            player:addKeyItem(xi.ki.IVORY_KEY)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.IVORY_KEY)
        end
    end
end

return battlefieldObject
