-----------------------------------
-- Area: Balgas Dais
-- Name: Mission Rank 2
-- !pos 299 -123 345 146
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
            player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2
        then
            player:setLocalVar("battlefieldWin", battlefield:getID())
        end

        if player:hasCompletedMission(player:getNation(), 5) then
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 1)
        else
            player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
        end
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 and player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_EMISSARY_WINDURST2 then
        if player:hasKeyItem(xi.ki.DARK_KEY) then
            npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
            player:delKeyItem(xi.ki.DARK_KEY)
            player:setMissionStatus(player:getNation(), 9)
        end
    end
end

return battlefield_object
