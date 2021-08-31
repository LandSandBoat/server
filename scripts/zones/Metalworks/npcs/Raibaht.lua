-----------------------------------
-- Area: Metalworks
--  NPC: Raibaht
-- Starts and Finishes Quest: Dark Legacy
-- Involved in Quest: The Usual, Riding on the Clouds
-- !pos -27 -10 -1 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_2") == 7) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SMILING_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)

    local darkLegacy = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 5)) then
        player:startEvent(933)
    elseif (darkLegacy == QUEST_AVAILABLE and mJob == xi.job.DRK and mLvl >= xi.settings.AF1_QUEST_LEVEL) then
        player:startEvent(751) -- Start Quest "Dark Legacy"
    elseif (player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA)) then
        player:startEvent(755) -- Finish Quest "Dark Legacy"
    elseif (player:hasKeyItem(xi.ki.STEAMING_SHEEP_INVITATION) and player:getCharVar("TheUsual_Event") ~= 1) then
        player:startEvent(510)
    else
        player:startEvent(501)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 510 and option == 0) then
        player:setCharVar("TheUsual_Event", 1)
    elseif (csid == 751) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
        player:setCharVar("darkLegacyCS", 1)
    elseif (csid == 755) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16798) -- Raven Scythe
        else
            player:delKeyItem(xi.ki.DARKSTEEL_FORMULA)
            player:addItem(16798)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16798) -- Raven Scythe
            player:setCharVar("darkLegacyCS", 0)
            player:addFame(BASTOK, 20)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
        end
    elseif (csid == 933) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 5, true))
    end

end

return entity
