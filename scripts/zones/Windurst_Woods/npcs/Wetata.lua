-----------------------------------
-- Area: Windurst Woods
--  NPC: Wetata
-- Trust NPC
-- !pos -23.825 2.533 -44.567 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.trust.onTradeCipher(player, trade, 862, 901, 902)
end

entity.onTrigger = function(player, npc)
    local trustSandoria = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local trustBastok   = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local trustWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)

    if
        player:getMainLvl() >= 5 and
        xi.settings.main.ENABLE_TRUST_QUESTS == 1 and
        trustWindurst == xi.questStatus.QUEST_AVAILABLE
    then
        if
            trustBastok == xi.questStatus.QUEST_AVAILABLE and
            trustSandoria == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(863)
        elseif
            trustBastok == xi.questStatus.QUEST_COMPLETED or
            trustSandoria == xi.questStatus.QUEST_COMPLETED
        then
            player:startEvent(867)
        end
    elseif player:hasKeyItem(xi.ki.GREEN_INSTITUTE_CARD) then
        player:startEvent(864)
    elseif trustWindurst == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(861)
    else
        player:startEvent(868)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 863 or csid == 867) and option == 2 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
        npcUtil.giveKeyItem(player, xi.ki.GREEN_INSTITUTE_CARD)
    elseif csid == 862 or csid == 902 then
        local spellID = player:getLocalVar('TradingTrustCipher')
        player:setLocalVar('TradingTrustCipher', 0)
        player:addSpell(spellID, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end

return entity
