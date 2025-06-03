-----------------------------------
-- Area: Selbina
--  NPC: Isacio
-- Finishes Quest: Elder Memories
-- !pos -54 -1 -44 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local questStatus = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES)

    if questStatus == xi.questStatus.QUEST_ACCEPTED then
        local IsacioElderMemVar = player:getCharVar('IsacioElderMemVar')

        if
            IsacioElderMemVar == 1 and
            npcUtil.tradeHas(trade, xi.item.MAGICKED_SKULL)
        then
            player:startEvent(115, xi.item.DAMSELFLY_WORM)
        elseif
            IsacioElderMemVar == 2 and
            npcUtil.tradeHas(trade, xi.item.DAMSELFLY_WORM)
        then
            player:startEvent(116, xi.item.CRAB_APRON)
        elseif
            IsacioElderMemVar == 3 and
            npcUtil.tradeHas(trade, xi.item.CRAB_APRON)
        then
            player:startEvent(117)
        end
    end
end

entity.onTrigger = function(player, npc)
    local questStatus = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES)

    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY) ~= xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(99)
    elseif questStatus == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(118)
    elseif questStatus == xi.questStatus.QUEST_ACCEPTED then
        local IsacioElderMemVar = player:getCharVar('IsacioElderMemVar')

        if player:hasKeyItem(xi.ki.GILGAMESHS_INTRODUCTORY_LETTER) then
            player:startEvent(117)
        elseif  IsacioElderMemVar == 1 then
            player:startEvent(114, xi.item.MAGICKED_SKULL)
        elseif IsacioElderMemVar == 2 then
            player:startEvent(114, xi.item.DAMSELFLY_WORM)
        elseif IsacioElderMemVar == 3 then
            player:startEvent(114, xi.item.CRAB_APRON)
        end
    else
        if player:getMainLvl() >= xi.settings.main.SUBJOB_QUEST_LEVEL then
            player:startEvent(111, xi.item.MAGICKED_SKULL)
        else
            player:startEvent(119)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 111 and option == 40 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES)
        player:setCharVar('IsacioElderMemVar', 1)
    elseif csid == 115 then
        player:confirmTrade()
        player:setCharVar('IsacioElderMemVar', 2)
    elseif csid == 116 then
        player:confirmTrade()
        player:setCharVar('IsacioElderMemVar', 3)
    elseif csid == 117 then
        player:confirmTrade()
        player:unlockJob(0)
        player:setCharVar('IsacioElderMemVar', 0)
        player:messageSpecial(ID.text.SUBJOB_UNLOCKED)
        player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES)
    end
end

return entity
