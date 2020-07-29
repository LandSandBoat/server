-----------------------------------
-- Area: Metalworks
--   NPC: High Bear
-- Type: Quest Giver
-- !pos 25.231 -14.999 4.552 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local BeaSmog = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BEADEAUX_SMOG)
    local keyitem = player:hasKeyItem(tpz.ki.CORRUPTED_DIRT)

    if (BeaSmog == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 4) then
        player:startEvent(731)
    elseif (BeaSmog == QUEST_ACCEPTED and keyitem == false or BeaSmog == QUEST_COMPLETED) then
        player:startEvent(730)
    elseif (BeaSmog == QUEST_ACCEPTED and keyitem == true) then
        player:startEvent(732)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 731) then
            player:addQuest(BASTOK, tpz.quest.id.bastok.BEADEAUX_SMOG)
    elseif (csid == 732) then
            player:addFame(BASTOK, 30)
            player:delKeyItem(tpz.ki.CORRUPTED_DIRT)
            player:addItem(17284, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17284)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.BEADEAUX_SMOG)
            player:setTitle(tpz.title.BEADEAUX_SURVEYOR)
    end
end
