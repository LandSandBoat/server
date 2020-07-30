-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: San d'Orian Emb.
-- San d'Oria Missions 3.3 "Appointment to Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pNation = player:getNation()

    if pNation == tpz.nation.SANDORIA then
        local currentMission = player:getCurrentMission(pNation)
        local MissionStatus = player:getCharVar("MissionStatus")

        if currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 6 then
            player:startEvent(39)
        elseif player:getRank() == 4 and
            currentMission == tpz.mission.id.sandoria.NONE and
            getMissionRankPoints(player, 13) == 1
        then
            if player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
                player:startEvent(130, 1)
            else
                player:startEvent(130)
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
    if csid == 39 then
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 130 and option == 1 then
        player:setCharVar("MissionStatus", 1)
        if not player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end
    end
end
