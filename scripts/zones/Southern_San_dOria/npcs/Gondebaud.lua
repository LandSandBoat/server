-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Gondebaud
-- Trust NPC
-- !pos 123.754 0.000 92.125 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.trust.onTradeCipher(player, trade, 3503, 3552, 3553)
end

entity.onTrigger = function(player, npc)
    local trustSandoria = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local trustBastok   = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local trustWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)

    if
        player:getMainLvl() >= 5 and
        xi.settings.main.ENABLE_TRUST_QUESTS == 1 and
        trustSandoria == xi.questStatus.QUEST_AVAILABLE
    then
        if
            trustWindurst == xi.questStatus.QUEST_AVAILABLE and
            trustBastok == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(3500)
        elseif
            trustWindurst == xi.questStatus.QUEST_COMPLETED or
            trustBastok == xi.questStatus.QUEST_COMPLETED
        then
            player:startEvent(3504)
        end
    elseif player:hasKeyItem(xi.ki.RED_INSTITUTE_CARD) then
        player:startEvent(3501)
    elseif trustSandoria == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(3502)
    else
        player:startEvent(3505)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 3500 or csid == 3504) and option == 2 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
        npcUtil.giveKeyItem(player, xi.ki.RED_INSTITUTE_CARD)
    elseif csid == 3503 or csid == 3553 then
        local spellID = player:getLocalVar('TradingTrustCipher')
        player:setLocalVar('TradingTrustCipher', 0)
        player:addSpell(spellID, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end

return entity
