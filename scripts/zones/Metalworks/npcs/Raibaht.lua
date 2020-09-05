-----------------------------------
-- Area: Metalworks
--  NPC: Raibaht
-- Starts and Finishes Quest: Dark Legacy
-- Involved in Quest: The Usual, Riding on the Clouds
-- !pos -27 -10 -1 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_2") == 7) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SMILING_STONE)
        end
    end

end

function onTrigger(player, npc)

    local darkLegacy = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.DARK_LEGACY)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 5) == false) then
        player:startEvent(933)
    elseif (darkLegacy == QUEST_AVAILABLE and mJob == tpz.job.DRK and mLvl >= AF1_QUEST_LEVEL) then
        player:startEvent(751) -- Start Quest "Dark Legacy"
    elseif (player:hasKeyItem(tpz.ki.DARKSTEEL_FORMULA)) then
        player:startEvent(755) -- Finish Quest "Dark Legacy"
    elseif (player:hasKeyItem(tpz.ki.STEAMING_SHEEP_INVITATION) and player:getCharVar("TheUsual_Event") ~= 1) then
        player:startEvent(510)
    else
        player:startEvent(501)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 510 and option == 0) then
        player:setCharVar("TheUsual_Event", 1)
    elseif (csid == 751) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.DARK_LEGACY)
        player:setCharVar("darkLegacyCS", 1)
    elseif (csid == 755) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16798) -- Raven Scythe
        else
            player:delKeyItem(tpz.ki.DARKSTEEL_FORMULA)
            player:addItem(16798)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16798) -- Raven Scythe
            player:setCharVar("darkLegacyCS", 0)
            player:addFame(BASTOK, 20)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.DARK_LEGACY)
        end
    elseif (csid == 933) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 5, true)
    end

end
