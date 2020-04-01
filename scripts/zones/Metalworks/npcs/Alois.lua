-----------------------------------
-- Area: Metalworks
--  NPC: Alois
-- Involved in Missions: Wading Beasts
-- !pos 96 -20 14 237
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/missions");
-----------------------------------

function onTrade(player,npc,trade)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.WADING_BEASTS and trade:hasItemQty(4362,1) and trade:getItemCount() == 1) then -- Trade Lizard Egg
        if (player:hasCompletedMission(BASTOK,tpz.mission.id.bastok.WADING_BEASTS) == false) then
            player:startEvent(372);
        else
            player:startEvent(373);
        end
    end
end;

function onTrigger(player,npc)
if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 0) then
player:startEvent(773);
elseif (player:getCharVar("BASTOK91") == 1) then
player:startEvent(774);
elseif (player:getCharVar("BASTOK91") == 3) then
player:startEvent(775);
elseif (player:getCharVar("BASTOK91") == 4) then
player:startEvent(776);
else
player:startEvent(370);
end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 372 or csid == 373) then
        finishMissionTimeline(player,1,csid,option);
    elseif (csid == 773) then
    player:setCharVar("BASTOK91",1);
    elseif (csid == 776) then
    player:setCharVar("BASTOK91",0);
    player:completeMission(BASTOK,tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH);
    player:addRankPoints(1500);
    player:setCharVar("OptionalcsCornelia",1);
    end

end;
