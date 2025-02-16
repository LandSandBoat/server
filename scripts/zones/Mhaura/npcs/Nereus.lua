-----------------------------------
-- Area: Mhaura
--  NPC: Nereus
-- Starts and ends repeteable quest A_POTTERS_PREFERENCE
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE) == xi.questStatus.QUEST_ACCEPTED or
        player:getCharVar('QuestAPotterPrefeRepeat_var') == 1
    then
        if npcUtil.tradeHas(trade, xi.item.DISH_OF_GUSGEN_CLAY) then
            player:startEvent(113) -- quest done!
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE) == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) > 5
    then
        player:startEvent(111, xi.item.DISH_OF_GUSGEN_CLAY) -- start quest A Potter's Preference
    elseif player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(114, xi.item.DISH_OF_GUSGEN_CLAY) -- get me dish_of_gusgen_clay  as soon as you can
    elseif player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE) == xi.questStatus.QUEST_COMPLETED then
        if
            player:getCharVar('QuestAPotterPrefeCompDay_var') + 7 < VanadielDayOfTheYear() or
            player:getCharVar('QuestAPotterPrefeCompYear_var') < VanadielYear()
        then
            -- seven days after copletition, allow to do the quest again
            player:startEvent(112) -- repeat quest
        else
            player:startEvent(115) -- i have enough for now, come later
        end
    else
        player:startEvent(110) --standar dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 111 and option == 1 then  --accept quest
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE)
    elseif csid == 113 then --quest completed
        player:confirmTrade()
        player:addFame(xi.fameArea.WINDURST, 120)
        npcUtil.giveCurrency(player, 'gil', 2160)
        player:setCharVar('QuestAPotterPrefeRepeat_var', 0)
        player:setCharVar('QuestAPotterPrefeCompDay_var', VanadielDayOfTheYear())
        player:setCharVar('QuestAPotterPrefeCompYear_var', VanadielYear())
        player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTERS_PREFERENCE)
    elseif csid == 112 then --repeat quest
        player:setCharVar('QuestAPotterPrefeRepeat_var', 1)
    end
end

return entity
