-----------------------------------
-- Area: Bastok Mines
--  NPC: Tall Mountain
-- Involved in Quest: Stamp Hunt
-- Finish Mission: Bastok 6-1
-- !pos 71 7 -7 234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local StampHunt = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STAMP_HUNT)

    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and player:getMissionStatus(player:getNation()) == 3) then
        player:startEvent(182)
    elseif (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 1)) then
        player:startEvent(85)
    else
        player:startEvent(55)
    end

end

-- 32693  55  85  176  180  182  591  593
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 182) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 85) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 1, true))
    end

end

return entity
