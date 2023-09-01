-----------------------------------
-- Area: Port San d'Oria
--  NPC: Antreneau
-- !pos -71 -5 -39 232
-- Involved in Quests: A Taste For Meat, Over The Hills And Far Away
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(532) -- What's this?  I don't need this.
end

entity.onTrigger = function(player, npc)
    local aTasteForMeat = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_TASTE_FOR_MEAT)
    local medicineWoman = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local diaryPage = player:getCharVar('DiaryPage')
    local fameLevel = player:getFameLevel(xi.quest.fame_area.SANDORIA)

    if
        player:getCharVar('Quest[0][100]Option') == 0 and
        aTasteForMeat == QUEST_COMPLETED and
        fameLevel >= 8 and
        medicineWoman == QUEST_COMPLETED and
        diaryPage >= 4
    then
        local overTheHillsAndFarAway = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)

        if overTheHillsAndFarAway == QUEST_AVAILABLE then
            player:startEvent(725) -- Start
        elseif overTheHillsAndFarAway == QUEST_ACCEPTED then
            player:startEvent(726) -- Talks about the map.
        elseif overTheHillsAndFarAway == QUEST_COMPLETED then
            player:startEvent(727) -- Found his uncle Louverance.
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 725 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)
    end
end

return entity
