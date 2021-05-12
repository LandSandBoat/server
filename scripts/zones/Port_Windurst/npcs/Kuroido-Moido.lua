-----------------------------------
-- Area: Port Windurst (240)
--  NPC: Kuriodo-Moido
-- Involved In Quest: Making Amends, Wonder Wands,
-- Starts and Finishes: Making Amens!, Orastery Woes
-- !pos -112.5 -4.2 102.9 240
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local makingAmends = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENDS) --First quest in series
    local makingAmens = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS) --Second quest in series
    local wonderWands = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WONDER_WANDS) --Third and final quest in series
    local pfame = player:getFameLevel(WINDURST)
    local needToZone = player:needToZone()
    local brokenWand = player:hasKeyItem(xi.ki.BROKEN_WAND)

    if (makingAmends == QUEST_ACCEPTED) then -- MAKING AMENDS: During Quest
        player:startEvent(276)
    elseif (makingAmends == QUEST_COMPLETED and makingAmens ~= QUEST_COMPLETED and wonderWands ~= QUEST_COMPLETED and needToZone) then -- MAKING AMENDS: After Quest
        player:startEvent(279)
    elseif (makingAmends == QUEST_COMPLETED and makingAmens == QUEST_AVAILABLE) then
        if (pfame >=4 and not needToZone) then
            player:startEvent(280) -- Start Making Amens! if prerequisites are met
        else
            player:startEvent(279) -- MAKING AMENDS: After Quest
        end
    elseif (makingAmens == QUEST_ACCEPTED and not brokenWand) then -- Reminder for Making Amens!
        player:startEvent(283)
    elseif (makingAmens == QUEST_ACCEPTED and brokenWand) then -- Complete Making Amens!
        player:startEvent(284, GIL_RATE*6000)
    elseif (makingAmens == QUEST_COMPLETED) then
        if (wonderWands == QUEST_ACCEPTED) then -- During Wonder Wands dialogue
            player:startEvent(261)
        elseif (wonderWands == QUEST_COMPLETED) then -- Post Wonder Wands dialogue
            player:startEvent(266)
        else
            player:startEvent(286, 0, 937) -- Post Making Amens! dialogue (before Wonder Wands)
        end
    elseif (player:getCurrentMission(ASA) == xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD) then
        local item = 0
        local asaStatus = player:getCharVar("ASA_Status")

        -- TODO: Other Enfeebling Kits
        if (asaStatus == 0) then
            item = 2779
        else
            printf("Error: Unknown ASA Status Encountered <%u>", asaStatus)
        end

        -- The Parameters are Item IDs for the Recipe
        player:startEvent(858, item, 1134, 2778, 2778, 4099, 2778)
    else
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(225)   -- Standard Conversation
        else
            player:startEvent(226)   -- Standard Conversation
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 280) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS)
    elseif (csid == 284) then
        player:needToZone(true)
        player:delKeyItem(xi.ki.BROKEN_WAND)
        player:addTitle(xi.title.HAKKURURINKURUS_BENEFACTOR)
        player:addGil(GIL_RATE*6000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*6000)
        player:addFame(WINDURST, 150)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS)
    end
end

return entity
