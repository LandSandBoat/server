-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Type: Standard Merchant
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP) ~= QUEST_COMPLETED and npcUtil.tradeHas(trade, 548) then
        -- Finish Quest: Tenshodo Membership (Invitation)
        player:startEvent(108)
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED and
           not player:hasKeyItem(tpz.ki.PSOXJA_PASS) and
           player:getCharVar("PXPassGetGems") == 1 and
           (npcUtil.tradeHas(trade, 1692) or npcUtil.tradeHas(trade, 1694) or npcUtil.tradeHas(trade, 1693)) then
        player:startEvent(52, 500 * GIL_RATE)
    end
end

function onTrigger(player, npc)
    local GetGems = player:getCharVar("PXPassGetGems")

    if player:getFameLevel(JEUNO) >= 2 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP) == QUEST_AVAILABLE then
        -- Start Quest: Tenshodo Membership
        player:startEvent(106, 8)
    elseif player:hasKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM) then
        -- Finish Quest: Tenshodo Membership
        player:startEvent(107)
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED and not player:hasKeyItem(tpz.ki.PSOXJA_PASS) and GetGems == 0 then
        -- Mission: Darkness Named
        player:startEvent(54)
    elseif (GetGems == 1) then
        player:startEvent(53)
    else
        player:startEvent(106, 4)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144,    -- Rice Ball
            4457, 2700,    -- Eel Kabob
            4467,    3,    -- Garlic Cracker
        }

        tpz.shop.general(player, stock, NORG)
    elseif csid == 106 and option == 2 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP)
    elseif csid == 107 then
        -- Finish Quest: Tenshodo Membership (Application Form)
        if npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item=548, title=tpz.title.TENSHODO_MEMBER, keyItem=tpz.ki.TENSHODO_MEMBERS_CARD }) then
            player:delKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM)
        end
    elseif csid == 108 then
        -- Finish Quest: Tenshodo Membership (Invitation)
        if npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item=548, title=tpz.title.TENSHODO_MEMBER, keyItem=tpz.ki.TENSHODO_MEMBERS_CARD }) then
            player:confirmTrade()
            player:delKeyItem(tpz.ki.TENSHODO_APPLICATION_FORM)
        end
    elseif csid == 52 then
        player:confirmTrade()
        player:addGil(500 * GIL_RATE)
        player:addKeyItem(tpz.ki.PSOXJA_PASS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PSOXJA_PASS)
        player:setCharVar("PXPassGetGems", 0)
    elseif csid == 54 then
        player:setCharVar("PXPassGetGems", 1)
    end
end
