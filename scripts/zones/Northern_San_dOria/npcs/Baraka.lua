-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Baraka
-- Involved in Missions 2-3
-- !pos 36 -2 -2 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(BASTOK) ~= xi.mission.id.bastok.NONE) then
        local missionStatus = player:getCharVar("MissionStatus")
        if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_EMISSARY) then
            if (missionStatus == 1) then
                player:startEvent(581)
            elseif (missionStatus == 2) then
                player:showText(npc, 11141)
            else
                player:startEvent(539)
            end
        end
    else
        local pNation = player:getNation()

        if (pNation == xi.nation.SANDORIA) then
            player:startEvent(580)
        elseif (pNation == xi.nation.WINDURST) then
            player:startEvent(579)
        else
            player:startEvent(539)
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 581) then
        -- This cs should only play if you visit San d'Oria first
        -- If you visit Windurst first you will encounter Lion in Heaven's Tower instead
        if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_EMISSARY
        and player:getCharVar("MissionStatus") < 2) then
            player:setCharVar("MissionStatus", 2)
            player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
        end
    end
end

return entity
