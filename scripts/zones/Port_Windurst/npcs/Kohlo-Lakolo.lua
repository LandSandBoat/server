-----------------------------------
-- Area: Port Windurst
--  NPC: Kohlo-Lakolo
-- Invloved In Quests:
-- Truth, Justice, and the Onion Way!,
-- Know One's Onions,
-- Inspector's Gadget,
-- Onion Rings,
-- Crying Over Onions,
-- Wild Card,
-- The Promise
-- !pos -26.8 -6 190 240
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local TruthJusticeOnionWay = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
    local KnowOnesOnions       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS)
    if TruthJusticeOnionWay == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, 4444) then
            player:startEvent(378, 0, 4444)
        end
    elseif KnowOnesOnions == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, {{4387, 4}}) and player:getCharVar("KnowOnesOnions") == 0 then
            player:startEvent(398, 0, 4387)
        end
    end
end

entity.onTrigger = function(player, npc)
    local TruthJusticeOnionWay = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
    local KnowOnesOnions       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS)
    local InspectorsGadget     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
    local OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    local CryingOverOnions     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local WildCard             = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)
    local ThePromise           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)
    local NeedToZone           = player:needToZone()
    local Level                = player:getMainLvl()
    local Fame                 = player:getFameLevel(WINDURST)

    if TruthJusticeOnionWay == QUEST_AVAILABLE then
        player:startEvent(368)
    elseif
        KnowOnesOnions == QUEST_AVAILABLE and TruthJusticeOnionWay == QUEST_COMPLETED and
        player:getMainLvl() >= 5 and player:getLocalVar('TruthZone') == 0 and Fame >=1
    then
        player:startEvent(391, 0, 4387)
    elseif KnowOnesOnions == QUEST_ACCEPTED and Level >= 5 and player:getCharVar("KnowOnesOnions") == 2 then
        player:startEvent(400)
    elseif
        InspectorsGadget == QUEST_AVAILABLE and KnowOnesOnions == QUEST_COMPLETED and
        player:getLocalVar("KnowOneOnionZone") == 0 and Fame >=2
    then
        player:startEvent(413)
    elseif InspectorsGadget == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.FAKE_MOUSTACHE) then
        player:startEvent(421)
    elseif
        OnionRings == QUEST_AVAILABLE and InspectorsGadget == QUEST_COMPLETED and
        player:getLocalVar('InspectorsGadgetZone') == 0 and Fame >=3 and not player:hasKeyItem(xi.ki.OLD_RING)
    then
        player:startEvent(429)
    elseif (OnionRings == QUEST_ACCEPTED or OnionRings == QUEST_AVAILABLE) and player:hasKeyItem(xi.ki.OLD_RING) then
        player:startEvent(430, 0, xi.ki.OLD_RING) --TODO get correct time for quest to expire.
    elseif CryingOverOnions == QUEST_AVAILABLE and OnionRings == QUEST_COMPLETED and Fame >=3 then
        player:startEvent(496)
    elseif CryingOverOnions == QUEST_ACCEPTED and player:getCharVar("CryingOverOnions") == 3 then
        player:startEvent(497)
    elseif WildCard == QUEST_ACCEPTED then
        player:startEvent(505)
    elseif ThePromise == QUEST_AVAILABLE and WildCard == QUEST_COMPLETED and Fame >=6 then
        player:startEvent(513, 0, xi.ki.INVISIBLE_MAN_STICKER)
    elseif ThePromise == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.INVISIBLE_MAN_STICKER) then
        player:startEvent(522, 0, xi.ki.INVISIBLE_MAN_STICKER)
    elseif ThePromise == QUEST_COMPLETED then
        player:startEvent(544)
    elseif KnowOnesOnions == QUEST_COMPLETED then
        player:startEvent(401)
    elseif TruthJusticeOnionWay == QUEST_COMPLETED then
        player:startEvent(379)
    else
        player:startEvent(361)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 368  and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
    elseif csid == 378 then
        if npcUtil.completeQuest(
            player,
            WINDURST,
            xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY,
            {item = 13093, title=xi.title.STAR_ONION_BRIGADE_MEMBER, fame=10})
        then
            player:setLocalVar('TruthZone', 1)
            player:tradeComplete()
        end
    elseif csid == 391 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS)
    elseif csid == 398 then
        player:setCharVar("KnowOnesOnions", 1)
        player:tradeComplete()
    elseif csid == 400 then
        if npcUtil.completeQuest(
            player,
            WINDURST,
            xi.quest.id.windurst.KNOW_ONE_S_ONIONS,
            {item = 4857, title=xi.title.SOB_SUPER_HERO, var="KnowOnesOnions", fame=10})
        then
            player:tradeComplete()
            player:setLocalVar("KnowOneOnionZone", 1)
        end
    elseif csid == 413 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
    elseif csid == 421 then
        if npcUtil.completeQuest(
            player,
            WINDURST,
            xi.quest.id.windurst.INSPECTOR_S_GADGET,
            {item = 13204, title=xi.title.FAKEMOUSTACHED_INVESTIGATOR, fame=10})
        then
            player:setLocalVar("InspectorsGadgetZone", 1)
        end
    elseif csid == 429 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    elseif csid == 430 then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS) == QUEST_AVAILABLE then
            player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
        end
        player:setCharVar("OnionRings", 1)
    elseif csid == 496 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    elseif csid == 497 then
        player:setCharVar("CryingOverOnions", 4)
    elseif csid == 505 then
        player:setCharVar("WildCard", 1)
    elseif csid == 513 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)
    elseif csid == 522 then
        if npcUtil.giveItem(player, 13135) then
            npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.THE_PROMISE)
        end
    end
end

return entity
