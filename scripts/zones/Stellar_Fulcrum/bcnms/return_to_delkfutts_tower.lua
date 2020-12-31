-----------------------------------
-- Area: Stellar Fulcrum
-- Name: ZM8 Return to Delkfutt's Tower
-- !pos -520 -4 17 179
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER then
            player:completeMission(ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
            player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.ROMAEVE)
            player:setCharVar("ZilartStatus", 0)
        end
        -- Play last CS if not skipped.
        if option == 1 then
            player:startEvent(17)
        end
    end
end
