-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Excenmille
-- Type: Trust NPC, Ballista Pursuivant
-- !pos -229.344 6.999 22.976 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

local TrustMemory = function(player)
    local memories = 0
    if player:hasKeyItem(tpz.ki.BALLISTA_LICENSE) then
        memories = memories + 2
    end
    -- 4 - Chocobo racing
    --  memories = memories + 4
    if player:hasCompletedQuest(WOTG, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) then
        memories = memories + 8
    end
    if player:hasCompletedQuest(WOTG, tpz.quest.id.crystalWar.BLOOD_OF_HEROES) then
        memories = memories + 16
    end
    return memories
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TrustSandoria = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TRUST_WINDURST)
    local SandoriaFirstTrust = player:getCharVar("SandoriaFirstTrust")
    local ExcenmilleTrustChatFlag = player:getLocalVar("ExcenmilleTrustChatFlag")
    local Rank3 = player:getRank() >= 3 and 1 or 0

    if TrustSandoria == QUEST_ACCEPTED and (TrustWindurst == QUEST_COMPLETED or TrustBastok == QUEST_COMPLETED) then
        player:startEvent(897, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustSandoria == QUEST_ACCEPTED and SandoriaFirstTrust == 0 then
        player:startEvent(893, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    elseif TrustSandoria == QUEST_ACCEPTED and SandoriaFirstTrust == 1 and ExcenmilleTrustChatFlag == 0 then
        player:startEvent(894)
        player:setLocalVar("ExcenmilleTrustChatFlag", 1)
    elseif TrustSandoria == QUEST_ACCEPTED and SandoriaFirstTrust == 2 then
        player:startEvent(895)
    elseif TrustSandoria == QUEST_COMPLETED and not player:hasSpell(902) and ExcenmilleTrustChatFlag == 0 then
        player:startEvent(896, 0, 0, 0, 0, 0, 0, 0, Rank3)
        player:setLocalVar("ExcenmilleTrustChatFlag", 1)
    else
        player:startEvent(29)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- TRUST
    if csid == 893 then
        player:addSpell(899, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 899)
        player:setCharVar("SandoriaFirstTrust", 1)
    elseif csid == 895 then
        player:delKeyItem(tpz.ki.RED_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.RED_INSTITUTE_CARD)
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA, {
            keyItem = tpz.ki.SAN_DORIA_TRUST_PERMIT,
            title = tpz.title.THE_TRUSTWORTHY,
            var = "SandoriaFirstTrust"
        })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 897 then
        player:addSpell(899, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 899)
        player:delKeyItem(tpz.ki.RED_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.RED_INSTITUTE_CARD)
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA, {
            keyItem = tpz.ki.SAN_DORIA_TRUST_PERMIT
        })
    end
end
