-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Curilla
-- Starts and Finishes Quest: The General's Secret, Enveloped in Darkness, Peace for the Spirit,
--                            Lure of the Wildcat (San d'Oria), Old Wounds
-- !pos 27 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

local wsQuest = tpz.wsquest.savage_blade

local TrustMemory = function(player)
    local memories = 0
    -- 2 - PEACE_FOR_THE_SPIRIT
    if player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) then
        memories = memories + 2
    end
    -- 4 - OLD_WOUNDS
    if player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.OLD_WOUNDS) then
        memories = memories + 4
    end
    -- 8 - THE_HEIR_TO_THE_LIGHT
    if player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) then
        memories = memories + 8
    end
    -- 16 - Heroine's Combat BCNM
    -- if (playervar for Heroine's Combat) then
    --  memories = memories + 16
    -- end
    -- 32 - FIT_FOR_A_PRINCE
    if player:hasCompletedQuest(SANDORIA, tpz.quest.id.sandoria.FIT_FOR_A_PRINCE) then
        memories = memories + 32
    end
    return memories
end

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end

end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local mLvL = player:getMainLvl()
    local mJob = player:getMainJob()
    local theGeneralSecret = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_GENERAL_S_SECRET)
    local envelopedInDarkness = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS)
    local peaceForTheSpirit = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local Rank3 = player:getRank() >= 3 and 1 or 0

    if player:hasKeyItem(tpz.ki.SAN_DORIA_TRUST_PERMIT) and not player:hasSpell(902) then
        player:startEvent(573, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        player:getMaskBit(WildcatSandy, 15) == false) then
        player:startEvent(562)
    elseif (theGeneralSecret == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 2) then
        player:startEvent(55) -- Start Quest "The General's Secret"
    elseif (mJob == tpz.job.RDM and mLvL >= AF2_QUEST_LEVEL and
        player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_COMPLETED and
        envelopedInDarkness == QUEST_AVAILABLE) then
        player:startEvent(94) -- Start Quest "Enveloped in Darkness"
    elseif (player:hasKeyItem(tpz.ki.OLD_POCKET_WATCH) and player:hasKeyItem(tpz.ki.OLD_BOOTS) == false) then
        player:startEvent(93)
    elseif (player:hasKeyItem(tpz.ki.OLD_BOOTS) and player:getCharVar("needs_crawler_blood") == 0) then
        player:startEvent(101)
    elseif (player:getCharVar("needs_crawler_blood") == 1) then
        player:startEvent(117)
    elseif (mJob == tpz.job.RDM and mLvL >= AF2_QUEST_LEVEL and envelopedInDarkness == QUEST_COMPLETED and
        peaceForTheSpirit == QUEST_AVAILABLE) then
        player:startEvent(109) -- Start Quest "Peace for the Spirit"
    elseif (peaceForTheSpirit == QUEST_ACCEPTED) then
        player:startEvent(108) -- Standard dialog during Peace of the spirit
    elseif (peaceForTheSpirit == QUEST_ACCEPTED and
        (player:getCharVar("peaceForTheSpiritCS") >= 2 and player:getCharVar("peaceForTheSpiritCS") <= 4)) then
        player:startEvent(113)
    elseif (peaceForTheSpirit == QUEST_ACCEPTED and player:getCharVar("peaceForTheSpiritCS") == 5) then
        player:startEvent(51)
    elseif (theGeneralSecret == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CURILLAS_BOTTLE_EMPTY)) then
        player:startEvent(53)
    elseif (theGeneralSecret == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CURILLAS_BOTTLE_FULL)) then
        player:startEvent(54)
    elseif (envelopedInDarkness == QUEST_COMPLETED and peaceForTheSpirit == QUEST_AVAILABLE) then
        player:startEvent(114) -- Standard dialog after Enveloped in darkness
    elseif (peaceForTheSpirit == QUEST_COMPLETED) then
        player:startEvent(52) -- Standard dialog after Peace of the spirit
    else
        player:startEvent(530) -- Standard dialog
    end

end

function onEventFinish(player, csid, option)
    if (csid == 55 and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_GENERAL_S_SECRET)
        player:addKeyItem(tpz.ki.CURILLAS_BOTTLE_EMPTY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CURILLAS_BOTTLE_EMPTY)
    elseif (csid == 54) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16409) -- Lynx Baghnakhs
        else
            player:delKeyItem(tpz.ki.CURILLAS_BOTTLE_FULL)
            player:addItem(16409)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16409) -- Lynx Baghnakhs
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_GENERAL_S_SECRET)
        end
    elseif (csid == 94 and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS)
        player:addKeyItem(tpz.ki.OLD_POCKET_WATCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OLD_POCKET_WATCH)
    elseif (csid == 109 and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)
        player:setCharVar("needs_crawler_blood", 0)
    elseif (csid == 101) then
        player:setCharVar("needs_crawler_blood", 1)
    elseif (csid == 562) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 15, true)
    elseif csid == 573 and option == 2 then
        player:addSpell(902, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 902)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.SAVAGE_BLADE_LEARNED)
    end
end
