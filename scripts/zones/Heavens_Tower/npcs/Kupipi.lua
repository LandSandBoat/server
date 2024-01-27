-----------------------------------
-- Area: Heaven's Tower
--  NPC: Kupipi
-- Involved in Mission 2-3
-- Involved in Quest: Riding on the Clouds
-- !pos 2 0.1 30 242
-----------------------------------
local ID = zones[xi.zone.HEAVENS_TOWER]
-----------------------------------
local entity = {}

local trustMemory = function(player)
    local memories = 0
    if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS) then
        memories = memories + 2
    end

    -- 4 - nothing
    if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) then
        memories = memories + 8
    end

    -- 16 - chocobo racing
    --  memories = memories + 16
    return memories
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local trustSandoria = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local trustBastok   = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local trustWindurst = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
    local windurstFirstTrust = player:getCharVar('WindurstFirstTrust')
    local kupipiTrustChatFlag = player:getLocalVar('KupipiTrustChatFlag')
    local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

    if
        trustWindurst == QUEST_ACCEPTED and
        (trustSandoria == QUEST_COMPLETED or trustBastok == QUEST_COMPLETED)
    then
        player:startEvent(439, 0, 0, 0, trustMemory(player), 0, 0, 0, rank3)
    elseif trustWindurst == QUEST_ACCEPTED and windurstFirstTrust == 0 then
        player:startEvent(435, 0, 0, 0, trustMemory(player), 0, 0, 0, rank3)
    elseif
        trustWindurst == QUEST_ACCEPTED and
        windurstFirstTrust == 1 and
        kupipiTrustChatFlag == 0
    then
        player:startEvent(436)
        player:setLocalVar('KupipiTrustChatFlag', 1)
    elseif trustWindurst == QUEST_ACCEPTED and windurstFirstTrust == 2 then
        player:startEvent(437)
    elseif
        trustWindurst == QUEST_COMPLETED and
        not player:hasSpell(xi.magic.spell.NANAA_MIHGO) and
        kupipiTrustChatFlag == 0
    then
        player:startEvent(438)
        player:setLocalVar('KupipiTrustChatFlag', 1)
    elseif player:getNation() == xi.nation.WINDURST then
        if player:getRank(player:getNation()) == 10 then
            player:startEvent(408) -- After achieving Windurst Rank 10, Kupipi has more to say
        else
            player:startEvent(251)
        end
    else
        player:startEvent(251)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    --TRUST
    if csid == 435 then
        player:addSpell(xi.magic.spell.KUPIPI, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.KUPIPI)
        player:setCharVar('WindurstFirstTrust', 1)
    elseif csid == 437 then
        player:delKeyItem(xi.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST, {
            ki = xi.ki.WINDURST_TRUST_PERMIT,
            title = xi.title.THE_TRUSTWORTHY,
            var = 'WindurstFirstTrust' })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 439 then
        player:addSpell(xi.magic.spell.KUPIPI, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.KUPIPI)
        player:delKeyItem(xi.ki.GREEN_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.GREEN_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST, {
            ki = xi.ki.WINDURST_TRUST_PERMIT })
    end
end

return entity
