-----------------------------------
-- Area: Metalworks
--  NPC: Lucius
-- Involved in Mission: Bastok 3-3
-- Involved in Quest: Riding on the Clouds
-- !pos 59.959 -17.39 -42.321 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/globals/missions");
local ID = require("scripts/zones/Metalworks/IDs");
-----------------------------------
local entity = {}

local function TrustMemory(player)
    local memories = 0
    -- 2 - Darkness Rising (Bastok Mission)
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.DARKNESS_RISING) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge (Bastok Mission)
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - Light of Judgment (Aht Urhgan Mission)
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 8
    end
    -- 16 - Hero's Combat (BCNM)
    -- if (playervar for Hero's Combat) then
    --  memories = memories + 16
    -- end
    return memories
end

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_2") == 8) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SMILING_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)
    local Rank6 = player:getRank(player:getNation()) >= 6 and 1 or 0

    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.JEUNO and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(322);
    elseif player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) and not player:hasSpell(903) then
        player:startEvent(986, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank6)
    else
        player:startEvent(320)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 322) then
        player:setMissionStatus(player:getNation(), 1);
        player:addKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR);
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_AMBASSADOR);
    elseif csid == 986 and option == 2 then
        player:addSpell(903, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 903)
    end

end

return entity
