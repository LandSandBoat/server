-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Guilberdrier
-- Involved in Quests: Flyers for Regine, Exit the Gambler
-- !pos -159.082 12.000 253.794 231
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 6) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local exitTheGambler = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER)
    local exitTheGamblerStat = player:getCharVar('exitTheGamblerStat')

    if
        exitTheGambler < xi.questStatus.QUEST_COMPLETED and
        exitTheGamblerStat == 0
    then
        player:startEvent(522)
    elseif
        exitTheGambler == xi.questStatus.QUEST_ACCEPTED and
        exitTheGamblerStat == 1
    then
        player:startEvent(518)
    else
        player:startEvent(514)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 522 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER) == xi.questStatus.QUEST_AVAILABLE
    then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER)
    elseif csid == 518 then
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER, {
            keyItem = xi.ki.MAP_OF_KING_RANPERRES_TOMB,
            exp = 2000,
            title = xi.title.DAYBREAK_GAMBLER
        })
    end
end

return entity
