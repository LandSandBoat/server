-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Bastokan Emb.
-- Bastok Missions 3.3 "Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pNation = player:getNation()

    if pNation == tpz.nation.BASTOK then
        local currentMission = player:getCurrentMission(pNation)
        local MissionStatus = player:getCharVar("MissionStatus")

        if currentMission == tpz.mission.id.bastok.JEUNO and MissionStatus == 4 then
            player:startEvent(38)
        elseif player:getRank() == 4 and
            currentMission == tpz.mission.id.bastok.NONE and
            getMissionRankPoints(player, 13) == 1
        then
            if player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
                player:startEvent(129, 1)
            else
                player:startEvent(129)
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
    if csid == 38 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 129 and option == 1 then
        player:setCharVar("MissionStatus", 1)
        if not player:hasKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end
    end
end
