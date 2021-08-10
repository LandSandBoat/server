-----------------------------------
-- Rank 2 Final Mission
-- Horlais Peak mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()

        if
            player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2 or
            player:getCurrentMission(xi.mission.log_id.BASTOK) == xi.mission.id.bastok.THE_EMISSARY_SANDORIA2
        then
            -- Note: This BCNM has an ID of 0; Setting the local var to some arbitrary non-zero value to ensure that it
            -- applies to the mission script as opposed to the BCNM ID.
            player:setLocalVar("battlefieldWin", 999)
        end

        local arg8 = player:hasCompletedMission(player:getNation(), 5) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if
            player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2 and
            player:getMissionStatus(player:getNation()) == 9
        then
            npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
            player:delKeyItem(xi.ki.DARK_KEY)
            player:setMissionStatus(player:getNation(), 10)
        end
    end
end

return battlefield_object
