-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Dhea Prandoleh
-- Type: Standard NPC
-- !pos 1 -1 15 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCampaignAllegiance() > 0 and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_AVAILABLE then
        player:startEvent(128)
    elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_ACCEPTED then
        player:startEvent(160)
    elseif
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_COMPLETED and
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_AVAILABLE
    then
        player:startEvent(135)
    elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED then
        if player:getCharVar("TigressStrikesProg") < 3 then
            player:startEvent(131)
        elseif player:getCharVar("TigressStrikesProg") == 3 then
            player:startEvent(134)
        end
    else
        player:startEvent(136)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 128 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS)
    elseif csid == 133 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES)
    elseif csid == 134 then
        player:addItem(139)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 139)
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES)
        player:needToZone(true)
        player:addTitle(tpz.title.AJIDOMARUJIDOS_MINDER)
    end
end
