-----------------------------------
-- Area: Windurst Woods
-- NPC: Wetata
-- Trust NPC
-- !pos -23.825 2.533 -44.567 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/trust")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.trust.onTradeCipher(player, trade, 862, 901, 902)
end

function onTrigger(player, npc)
    local TrustSandoria = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA)
    local TrustBastok   = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRUST_BASTOK)
    local TrustWindurst = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.TRUST_WINDURST)

    if player:getMainLvl() >= 5 and ENABLE_TRUST_QUESTS == 1 then
        if TrustWindurst == QUEST_AVAILABLE and (TrustBastok == QUEST_COMPLETED or TrustSandoria == QUEST_COMPLETED) then
            player:startEvent(867)
        elseif TrustWindurst == QUEST_AVAILABLE and TrustBastok == QUEST_AVAILABLE and TrustSandoria == QUEST_AVAILABLE then
            player:startEvent(863)
        end
    elseif player:hasKeyItem(tpz.ki.GREEN_INSTITUTE_CARD) then
        player:startEvent(864)
    elseif TrustWindurst == QUEST_COMPLETED then
        player:startEvent(861)
    else
        player:startEvent(868)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 863 or csid == 867) and option == 2 then
        player:addQuest(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.TRUST_WINDURST)
        npcUtil.giveKeyItem(player, tpz.ki.GREEN_INSTITUTE_CARD)
    elseif csid == 862 or csid == 902 then
        local spellID = player:getLocalVar("TradingTrustCipher")
        player:setLocalVar("TradingTrustCipher", 0)
        player:addSpell(spellID, false, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end
