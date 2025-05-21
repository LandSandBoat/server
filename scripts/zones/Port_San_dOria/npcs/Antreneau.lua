-----------------------------------
-- Area: Port San d'Oria
--  NPC: Antreneau
-- !pos -71 -5 -39 232
-- Involved in Quests: A Taste For Meat, Over The Hills And Far Away
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(532) -- What's this?  I don't need this.
end

entity.onTrigger = function(player, npc)
    local aTasteForMeat = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_TASTE_FOR_MEAT)
    local medicineWoman = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local diaryPage = player:getCharVar('DiaryPage')
    local fameLevel = player:getFameLevel(xi.fameArea.SANDORIA)

    if
        player:getCharVar('Quest[0][100]Option') == 0 and
        aTasteForMeat == xi.questStatus.QUEST_COMPLETED and
        fameLevel >= 8 and
        medicineWoman == xi.questStatus.QUEST_COMPLETED and
        diaryPage >= 4
    then
        local overTheHillsAndFarAway = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)

        if overTheHillsAndFarAway == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(725) -- Start
        elseif overTheHillsAndFarAway == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(726) -- Talks about the map.
        elseif overTheHillsAndFarAway == xi.questStatus.QUEST_COMPLETED then
            player:startEvent(727) -- Found his uncle Louverance.
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 725 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)
    end
end

return entity
