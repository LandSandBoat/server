-----------------------------------
-- Area: Mhaura
--  NPC: Nereus
-- Starts and ends repeteable quest A_POTTER_S_PREFERENCE
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

--    player:startEvent(110) -- standar dialog
--    player:startEvent(115) -- i have enough for now, come later
--    player:startEvent(114) -- get me x as soon as you can
--    player:startEvent(111) -- start quest A Potter's Preference
--    player:startEvent(113) -- quest done!
--    player:startEvent(112) -- repeat quest

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_ACCEPTED or
        player:getCharVar("QuestAPotterPrefeRepeat_var") == 1
    then
        if npcUtil.tradeHas(trade, 569) then
            player:startEvent(113) -- quest done!
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) > 5
    then
        player:startEvent(111, 569) -- start quest A Potter's Preference
    elseif player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_ACCEPTED then
        player:startEvent(114, 569) -- get me dish_of_gusgen_clay  as soon as you can
    elseif player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_COMPLETED then
        if
            player:getCharVar("QuestAPotterPrefeCompDay_var") + 7 < VanadielDayOfTheYear() or
            player:getCharVar("QuestAPotterPrefeCompYear_var") < VanadielYear()
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 111 and option == 1 then  --accept quest
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE)
    elseif csid == 113 then --quest completed
        player:confirmTrade()
        player:addFame(xi.quest.fame_area.WINDURST, 120)
        npcUtil.giveCurrency(player, 'gil', 2160)
        player:setCharVar("QuestAPotterPrefeRepeat_var", 0)
        player:setCharVar("QuestAPotterPrefeCompDay_var", VanadielDayOfTheYear())
        player:setCharVar("QuestAPotterPrefeCompYear_var", VanadielYear())
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_POTTER_S_PREFERENCE)
    elseif csid == 112 then --repeat quest
        player:setCharVar("QuestAPotterPrefeRepeat_var", 1)
    end
end

return entity
