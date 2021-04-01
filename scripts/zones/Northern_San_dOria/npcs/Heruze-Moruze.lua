-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Heruze-Moruze
-- Involved in Mission: 2-3 Windurst
-- !pos -56 -3 36 231
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)

    if (pNation == xi.nation.WINDURST) then
        if (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS and player:getCharVar("MissionStatus") == 1) then
            player:startEvent(582)
        else
            player:startEvent(554)
        end
    elseif (pNation == xi.nation.BASTOK) then
        player:startEvent(578)
    elseif (pNation == xi.nation.SANDORIA) then
        player:startEvent(577)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 582) then
        player:setCharVar("MissionStatus", 2)
    end

end

return entity
