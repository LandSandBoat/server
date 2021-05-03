-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Bastokan Emb.
-- Bastok Missions 3.3 "Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.BASTOK then
        local currentMission = player:getCurrentMission(pNation)
        local missionStatus = player:getMissionStatus(player:getNation())

        if currentMission == xi.mission.id.bastok.JEUNO and missionStatus == 4 then
            player:startEvent(38)
        elseif player:getRank() == 4 and
            currentMission == xi.mission.id.bastok.NONE and
            getMissionRankPoints(player, 13) == 1
        then
            if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 38 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 129 and option == 1 then
        player:setMissionStatus(player:getNation(), 1)
        if not player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
            player:addKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end
    end
end

return entity
