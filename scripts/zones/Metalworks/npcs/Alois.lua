-----------------------------------
-- Area: Metalworks
--  NPC: Alois
-- Involved in Missions: Wading Beasts
-- !pos 96 -20 14 237
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 0) then
        player:startEvent(773)
    elseif (player:getCharVar("BASTOK91") == 1) then
        player:startEvent(774)
    elseif (player:getCharVar("BASTOK91") == 3) then
        player:startEvent(775)
    elseif (player:getCharVar("BASTOK91") == 4) then
        player:startEvent(776)
    elseif (player:getCharVar("FadedPromises") == 4) then
        player:startEvent(805)
    else
        player:startEvent(370)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 773) then
        player:setCharVar("BASTOK91", 1)
    elseif (csid == 776) then
        player:setCharVar("BASTOK91", 0)
        player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_SALT_OF_THE_EARTH)
        player:addRankPoints(1500)
        player:setCharVar("OptionalcsCornelia", 1)
    elseif (csid == 805) then
        if npcUtil.completeQuest(
            player,
            xi.quest.log_id.BASTOK,
            xi.quest.id.bastok.FADED_PROMISES,
            {item = 17775, xi.title.ASSASSIN_REJECT, var = {"FadedPromises"}, fame=10})
        then
            player:delKeyItem(xi.ki.DIARY_OF_MUKUNDA)
        end
    end
end

return entity
