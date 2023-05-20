-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Balasiel
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test, Methods Create Madness
-- !pos -136 -11 64 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST) == QUEST_ACCEPTED then
        if trade:hasItemQty(940, 1) and trade:getItemCount() == 1 then
            player:startEvent(617)
        end
    end
end

entity.onTrigger = function(player, npc)
    local lvl = player:getMainLvl()
    local aSquiresTest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST)
    local aSquiresTestII = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST_II)
    local aKnightsTest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHT_S_TEST)

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER) == QUEST_ACCEPTED and
        player:getCharVar("KnightStalker_Progress") == 2
    then
        player:startEvent(63) -- DRG AF3 cutscene, doesn't appear to have a follow up.
    if lvl < 15 then
        player:startEvent(671) -- Event does occur, but need to confirm level required
    elseif lvl >= 15 and aSquiresTestII ~= QUEST_COMPLETED then
        local hasStalactiteDew = player:hasKeyItem(xi.ki.STALACTITE_DEW)

        if aSquiresTestII == QUEST_AVAILABLE then
            player:startEvent(625)
        elseif aSquiresTestII == QUEST_ACCEPTED and not hasStalactiteDew then
            player:startEvent(630)
        elseif hasStalactiteDew then
            player:startEvent(626)
        else
            player:startEvent(667)
        end
    elseif lvl >= 15 and lvl < 30 then
        player:startEvent(670)
    elseif lvl >= 30 and aKnightsTest ~= QUEST_COMPLETED then
        if aKnightsTest == 0 then
            if player:getCharVar("KnightsTest_Event") == 1 then
                player:startEvent(635)
            else
                player:startEvent(627)
            end
        elseif player:hasKeyItem(xi.ki.KNIGHTS_SOUL) then
            player:startEvent(628)
        else
            player:startEvent(669)
        end
    else
        player:startEvent(667)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 625 or csid == 630 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST_II)
    elseif csid == 626 then
        player:tradeComplete()
        player:addTitle(xi.title.SPELUNKER)
        player:delKeyItem(xi.ki.STALACTITE_DEW)
        player:addKeyItem(xi.ki.SQUIRE_CERTIFICATE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SQUIRE_CERTIFICATE)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST_II)
    elseif csid == 627 then
        if option == 0 then
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHT_S_TEST)
            player:addKeyItem(xi.ki.BOOK_OF_TASKS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOOK_OF_TASKS)
        else
            player:setCharVar("KnightsTest_Event", 1)
        end
    elseif csid == 635 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHT_S_TEST)
        player:addKeyItem(xi.ki.BOOK_OF_TASKS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOOK_OF_TASKS)
        player:setCharVar("KnightsTest_Event", 0)
    elseif csid == 628 then
        if player:getFreeSlotsCount(0) >= 1 then
            player:addTitle(xi.title.TRIED_AND_TESTED_KNIGHT)
            player:delKeyItem(xi.ki.KNIGHTS_SOUL)
            player:delKeyItem(xi.ki.BOOK_OF_TASKS)
            player:delKeyItem(xi.ki.BOOK_OF_THE_WEST)
            player:delKeyItem(xi.ki.BOOK_OF_THE_EAST)
            player:addItem(12306)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12306) -- Kite Shield
            player:unlockJob(xi.job.PLD)
            player:messageSpecial(ID.text.UNLOCK_PALADIN)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHT_S_TEST)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12306) -- Kite Shield
        end
    elseif csid == 63 then
        player:setCharVar("KnightStalker_Progress", 3)
    end
end

--    player:startEvent(32690)     -- starlight celebration

return entity
