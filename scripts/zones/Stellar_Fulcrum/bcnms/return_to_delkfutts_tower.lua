-----------------------------------
-- Area: Stellar Fulcrum
-- Name: ZM8 Return to Delkfutt's Tower
-- !pos -520 -4 17 179
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
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
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER then
            player:completeMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
            player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.ROMAEVE)
            player:setCharVar("ZilartStatus", 0)
        end
        -- Play last CS if not skipped.
        if option == 1 then
            player:startEvent(17)
        end
    end
end

return battlefield_object
