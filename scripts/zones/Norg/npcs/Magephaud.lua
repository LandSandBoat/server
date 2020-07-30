-----------------------------------
-- Area: Norg
--  NPC: Magephaud
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    EveryonesGrudge = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.EVERYONES_GRUDGE)
    if (EveryonesGrudge == QUEST_ACCEPTED) then
        if (trade:hasItemQty(748, 3) and trade:getItemCount() == 3) then
            player:startEvent(118, 748)
        end
    end
end

function onTrigger(player, npc)

    nFame = player:getFameLevel(NORG)
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.EVERYONES_GRUDGE) == QUEST_AVAILABLE and player:getCharVar("EVERYONES_GRUDGE_KILLS") >= 1 and nFame >= 2) then
        player:startEvent(116, 748)  -- Quest start - you have tonberry kills?! I got yo back ^.-
    elseif (player:getCharVar("EveryonesGrudgeStarted")  == 1) then
        player:startEvent(117, 748)
    elseif (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.EVERYONES_GRUDGE) == QUEST_COMPLETED) then
        player:startEvent(119)  -- After completion cs
    else
        player:startEvent(115)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 116) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.EVERYONES_GRUDGE)
        player:setCharVar("EveryonesGrudgeStarted", 1)
    elseif (csid == 118) then
        player:completeQuest(OUTLANDS, tpz.quest.id.outlands.EVERYONES_GRUDGE)
        player:tradeComplete()
        player:addFame(NORG, 80)
        player:addKeyItem(tpz.ki.TONBERRY_PRIEST_KEY)    -- Permanent Tonberry key
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TONBERRY_PRIEST_KEY)
        player:setCharVar("EveryonesGrudgeStarted", 0)
        player:addTitle(tpz.title.HONORARY_DOCTORATE_MAJORING_IN_TONBERRIES)
    end
end
