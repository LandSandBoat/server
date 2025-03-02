-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Engelhart
-- pos -79 -4 -125
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('BetterPartOfValProg') == 0 then
            player:startEvent(116)
        elseif player:getCharVar('BetterPartOfValProg') == 4 then
            player:startEvent(118)
        else
            player:startEvent(117)
        end
    elseif
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(120)
    elseif player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('FiresOfDiscProg') < 2 then
            player:startEvent(121)
        elseif player:getCharVar('FiresOfDiscProg') == 2 then
            player:startEvent(124)
        elseif player:getCharVar('FiresOfDiscProg') == 3 then
            player:startEvent(125)
        elseif player:getCharVar('FiresOfDiscProg') == 4 then
            player:startEvent(126)
        elseif player:getCharVar('FiresOfDiscProg') == 5 then
            player:startEvent(127)
        elseif player:getCharVar('FiresOfDiscProg') == 6 then
            player:startEvent(164)
        end
    elseif player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(165)
    else
        player:startEvent(104)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 116 then
        player:setCharVar('BetterPartOfValProg', 1)
        player:delKeyItem(xi.ki.CLUMP_OF_ANIMAL_HAIR)
    elseif csid == 118 then
        player:delKeyItem(xi.ki.XHIFHUT)
        player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        npcUtil.giveKeyItem(player, xi.ki.WARNING_LETTER)
        npcUtil.giveCurrency(player, 'gil', 10000)
        player:setCharVar('BetterPartOfValProg', 0)
        player:needToZone(true)
    elseif csid == 120 then
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT)
        player:delKeyItem(xi.ki.WARNING_LETTER)
    elseif csid == 124 then
        player:setCharVar('FiresOfDiscProg', 3)
    elseif csid == 126 then
        player:setCharVar('FiresOfDiscProg', 5)
    elseif csid == 164 then
        player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT)
        npcUtil.giveCurrency(player, 'gil', 10000)
        player:setCharVar('FiresOfDiscProg', 0)
    end
end

return entity
