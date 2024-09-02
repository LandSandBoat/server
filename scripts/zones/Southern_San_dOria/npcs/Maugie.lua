-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Maugie
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 12) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local grimySignpost = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    if
        grimySignpost == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 2
    then
        player:startEvent(45)
    elseif grimySignpost == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('CleanSignPost') == 15 then
            player:startEvent(44)
        else
            player:startEvent(43)
        end
    elseif grimySignpost == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(42)
    else
        player:startEvent(46) -- default text
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 45 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    elseif csid == 44 then
        player:setCharVar('CleanSignPost', 0)
        player:addFame(xi.fameArea.SANDORIA, 30)
        npcUtil.giveCurrency(player, 'gil', 1500)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    end
end

return entity
