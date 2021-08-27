-----------------------------------
-- Area: Bastok Mines
--  NPC: Deidogg
-- Starts and Finishes Quest: The Talekeeper's Truth, The Talekeeper's Gift (start)
-- !pos -13 7 29 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getCharVar("theTalekeeperTruthCS") == 3) then
        if (trade:hasItemQty(1101, 1) and trade:getItemCount() == 1) then -- Trade Mottled Quadav Egg
            player:startEvent(162)
        end
    elseif (player:getCharVar("theTalekeeperTruthCS") == 4) then
        if (trade:hasItemQty(1099, 1) and trade:getItemCount() == 1) then -- Trade Parasite Skin
            player:startEvent(164)
        end
    elseif (player:getCharVar("theTalekeeperGiftCS") == 2) then
        if (trade:hasItemQty(4394, 1) and trade:getItemCount() == 1) then -- Trade Ginger Cookie
            player:startEvent(172)
        end
    end

end

entity.onTrigger = function(player, npc)

    local theDoorman = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)
    local theTalekeeperTruth = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH)
    local theTalekeeperTruthCS = player:getCharVar("theTalekeeperTruthCS")
    local Wait1DayForAF3 = player:getCharVar("DeidoggWait1DayForAF3")
    local theTalekeeperGiftCS = player:getCharVar("theTalekeeperGiftCS")
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 18)) then
        player:startEvent(504)
    elseif (theDoorman == QUEST_COMPLETED and theTalekeeperTruth == QUEST_AVAILABLE and player:getMainJob() == xi.job.WAR and player:getMainLvl() >= 50) then
        if (theTalekeeperTruthCS == 1) then
            player:startEvent(160)
            player:setCharVar("theTalekeeperTruthCS", 2)
        elseif (theTalekeeperTruthCS == 2) then
            player:startEvent(161) -- Start Quest "The Talekeeper's Truth"
        else
            player:startEvent(32) -- Standard dialog
        end
    elseif (theTalekeeperTruthCS == 4) then
        player:startEvent(163) -- During Quest "The Talekeeper's Truth"
    elseif (theTalekeeperTruthCS == 5 and VanadielDayOfTheYear() ~= player:getCharVar("theTalekeeperTruth_timer")) then
        player:startEvent(165) -- Finish Quest "The Talekeeper's Truth"
    elseif (theTalekeeperTruthCS == 5 or (theTalekeeperTruth == QUEST_COMPLETED and (player:needToZone() or VanadielDayOfTheYear() == Wait1DayForAF3))) then
        player:startEvent(166) -- New standard dialog after "The Talekeeper's Truth"
    elseif (player:needToZone() == false and VanadielDayOfTheYear() ~= Wait1DayForAF3 and Wait1DayForAF3 ~= 0 and theTalekeeperGiftCS == 0 and player:getMainJob() == xi.job.WAR) then
        player:startEvent(170)
        player:setCharVar("theTalekeeperGiftCS", 1)
        player:setCharVar("DeidoggWait1DayForAF3", 0)
    else
        player:startEvent(32) -- Standard dialog
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 161) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH)
        player:setCharVar("theTalekeeperTruthCS", 3)
    elseif (csid == 162) then
        player:tradeComplete()
        player:setCharVar("theTalekeeperTruthCS", 4)
    elseif (csid == 164) then
        player:tradeComplete()
        player:setCharVar("theTalekeeperTruthCS", 5)
        player:setCharVar("theTalekeeperTruth_timer", VanadielDayOfTheYear())
    elseif (csid == 165) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14089) -- Fighter's Calligae
        else
            player:addItem(14089)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14089) -- Fighter's Calligae
            player:setCharVar("theTalekeeperTruthCS", 0)
            player:setCharVar("theTalekeeperTruth_timer", 0)
            player:setCharVar("DeidoggWait1DayForAF3", VanadielDayOfTheYear())
            player:needToZone(true)
            player:addFame(BASTOK, 40)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH)
        end
    elseif (csid == 172) then
        player:tradeComplete()
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_GIFT)
        player:setCharVar("theTalekeeperGiftCS", 3)
    elseif (csid == 504) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 18, true))
    end

end

return entity
