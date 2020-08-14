-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Heruze-Moruze
-- Involved in Mission: 2-3 Windurst
-- !pos -56 -3 36 231
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)

    if (pNation == tpz.nation.WINDURST) then
        if (currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS and player:getCharVar("MissionStatus") == 1) then
            player:startEvent(582)
        else
            player:startEvent(554)
        end
    elseif (pNation == tpz.nation.BASTOK) then
        player:startEvent(578)
    elseif (pNation == tpz.nation.SANDORIA) then
        player:startEvent(577)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 582) then
        player:setCharVar("MissionStatus", 2)
    end

end
