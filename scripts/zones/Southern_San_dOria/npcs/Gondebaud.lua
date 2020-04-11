-----------------------------------
-- Area: Southern San d'Oria
-- NPC: Gondebaud
-- Trust NPC
-- !pos 123.754 0.000 92.125 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/trust")
-----------------------------------

function onTrade(player,npc,trade)
    local hasPermit = player:hasKeyItem(tpz.ki.WINDURST_TRUST_PERMIT) or
                      player:hasKeyItem(tpz.ki.BASTOK_TRUST_PERMIT) or
                      player:hasKeyItem(tpz.ki.SAN_DORIA_TRUST_PERMIT)

    if hasPermit and trade:getSlotCount() == 1 and trade:getItemSubId(0) ~= 0 and trade:getItemId(0) >= 10112 and trade:getItemId(0) <= 10193 then
        player:setLocalVar("TradingTrustCipher", trade:getItemSubId(0))
        player:startEvent(3503, 0, 0, 0, trade:getItemId(0))
    end
end

function onTrigger(player,npc)
    local TrustSandoria = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok   = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TRUST_WINDURST)

    if player:getMainLvl() >= 5 and ENABLE_TRUST_QUESTS == 1 then
        if TrustSandoria == QUEST_AVAILABLE and (TrustWindurst == QUEST_COMPLETED or TrustBastok == QUEST_COMPLETED) then
            player:startEvent(3504)
        elseif TrustSandoria == QUEST_AVAILABLE and TrustWindurst == QUEST_AVAILABLE and TrustBastok == QUEST_AVAILABLE then
            player:startEvent(3500)
        end
    elseif player:hasKeyItem(tpz.ki.RED_INSTITUTE_CARD) then
        player:startEvent(3501)
    elseif TrustSandoria == QUEST_COMPLETED then
        player:startEvent(3502)
    else
        player:startEvent(3505)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if (csid == 3500 or csid == 3504) and option == 2 then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA)
        npcUtil.giveKeyItem(player, tpz.ki.RED_INSTITUTE_CARD)
    elseif csid == 3503 then
        local spellID = player:getLocalVar("TradingTrustCipher")
        player:setLocalVar("TradingTrustCipher", 0)
        player:addSpell(spellID, false, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end
