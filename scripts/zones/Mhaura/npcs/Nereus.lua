-----------------------------------
-- Area: Mhaura
--  NPC: Nereus
-- Starts and ends repeteable quest A_POTTER_S_PREFERENCE
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
--    player:startEvent(110) -- standar dialog
--    player:startEvent(115) -- i have enough for now, come later
--    player:startEvent(114) -- get me x as soon as you can
--    player:startEvent(111) -- start quest A Potter's Preference
--    player:startEvent(113) -- quest done!
--    player:startEvent(112) -- repeat quest

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_ACCEPTED or player:getCharVar("QuestAPotterPrefeRepeat_var") == 1 then
        if npcUtil.tradeHas(trade, 569) then
            player:startEvent(113) -- quest done!
        end
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 5 then
        player:startEvent(111, 569) -- start quest A Potter's Preference
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_ACCEPTED then
        player:startEvent(114, 569) -- get me dish_of_gusgen_clay  as soon as you can
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE) == QUEST_COMPLETED then
        if player:getCharVar("QuestAPotterPrefeCompDay_var")+7 < VanadielDayOfTheYear() or player:getCharVar("QuestAPotterPrefeCompYear_var") < VanadielYear() then
            -- seven days after copletition, allow to do the quest again
            player:startEvent(112) -- repeat quest
        else
            player:startEvent(115) -- i have enough for now, come later
        end
    else
        player:startEvent(110) --standar dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 111 and option == 1 then  --accept quest
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE)
    elseif csid == 113 then --quest completed
        player:confirmTrade()
        player:addFame(WINDURST, 120)
        player:addGil(GIL_RATE*2160)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2160)
        player:setCharVar("QuestAPotterPrefeRepeat_var", 0)
        player:setCharVar("QuestAPotterPrefeCompDay_var", VanadielDayOfTheYear())
        player:setCharVar("QuestAPotterPrefeCompYear_var", VanadielYear())
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_POTTER_S_PREFERENCE)
    elseif csid == 112 then --repeat quest
        player:setCharVar("QuestAPotterPrefeRepeat_var", 1)
    end
end
