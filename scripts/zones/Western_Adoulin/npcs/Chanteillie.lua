-----------------------------------
-- Area: Western Adoulin
--  NPC: Chanteillie
-- Type: Standard NPC and Quest NPC
-- Involved with Quests: 'Do Not Go Into the Light'
--                       'Vegetable Vegetable Crisis'
-- !pos 89 0 -75 256
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local DNGITL = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DO_NOT_GO_INTO_THE_LIGHT)
    local VVC = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.VEGETABLE_VEGETABLE_CRISIS)

    -- DO NOT GO INTO THE LIGHT (Urunday Lumber, Damascus Ingot, Fire Crystal)
    if (DNGITL == QUEST_ACCEPTED and player:getCharVar("DNGITL_Status") == 3 and npcUtil.tradeHas(trade, {3927, 658, 4096})) then
        player:startEvent(5076)

    -- VEGETABLE VEGETABLE CRISIS (Urunday Lumber, Midrium Ingot, Raaz Leather)
    elseif (VVC == QUEST_ACCEPTED and player:getCharVar("VVC_Status") == 1 and npcUtil.tradeHas(trade, {3927, 3919, 8708})) then
        player:startEvent(5089)
    end
end

entity.onTrigger = function(player, npc)
    local DNGITL = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DO_NOT_GO_INTO_THE_LIGHT)
    local VVC = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.VEGETABLE_VEGETABLE_CRISIS)

    -- DO NOT GO INTO THE LIGHT
    if (DNGITL == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.INVENTORS_COALITION_PICKAXE)) then
        player:startEvent(5077)

    -- VEGETABLE VEGETABLE CRISIS
    elseif (VVC == QUEST_ACCEPTED and player:getCharVar("VVC_Status") == 1) then
        player:startEvent(5088)

    -- STANDARD DIALOGS
    elseif (player:getCurrentMission(SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        player:startEvent(588) -- Standard dialogue
    else
        player:startEvent(531) -- Dialogue prior to joining colonization effort
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- DO NOT GO INTO THE LIGHT
    if (csid == 5076) then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.INVENTORS_COALITION_PICKAXE)
        player:setCharVar("DNGITL_Status", 0)

    -- VEGETABLE VEGETABLE CRISIS
    elseif (csid == 5089) then
        player:confirmTrade()
        player:setCharVar("VVC_Status", 2)
        player:setCharVar("VVC_Gameday_Wait", vanaDay())
    end
end

return entity
