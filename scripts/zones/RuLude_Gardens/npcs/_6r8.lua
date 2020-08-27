-----------------------------------
-- Area: Ru'Lud Gardens
-- Door: Windurstian Ambassador
-- Windurst Missions 3.3 "A New Journey" and 4.1 "Magicite"
-- !pos 31 9 -22 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pNation = player:getNation()

    if pNation == tpz.nation.WINDURST then
        local currentMission = player:getCurrentMission(pNation)
        local MissionStatus = player:getCharVar("MissionStatus")

        if currentMission == tpz.mission.id.windurst.A_NEW_JOURNEY and MissionStatus == 4 then
            player:startEvent(40)
        elseif player:getRank() == 4 and
            currentMission == tpz.mission.id.windurst.NONE and
            getMissionRankPoints(player, 13) == 1
        then
            if player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
                player:startEvent(131, 1)
            else
                player:startEvent(131)
            end
        elseif player:getRank() >= 4 then
            player:messageSpecial(ID.text.RESTRICTED)
        else
            player:messageSpecial(ID.text.RESTRICTED+1) -- you have no letter of introduction
        end
    else
        player:messageSpecial(ID.text.RESTRICTED+1) -- you have no letter of introduction
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 40 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 131 and option == 1 then
        player:setCharVar("MissionStatus", 1)
        if not player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end
    end
end
