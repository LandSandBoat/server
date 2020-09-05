-----------------------------------
-- Area: South San d'Oria
--  NPC: Diary
-- Involved in Quest: To Cure a Cough, Over The Hills And Far Away
-- !pos -75 -12 65 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local aSquiresTestII = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST_II)
    local medicineWoman = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local toCureaCough = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TO_CURE_A_COUGH)
    local diaryPage = player:getCharVar("DiaryPage")

    if diaryPage == 0 then
        player:startEvent(639)          -- see diary, option to read (reads page 1)
    elseif diaryPage == 1 then
        player:startEvent(640)          -- reads page 2
    elseif diaryPage == 2 then
        if medicineWoman == QUEST_COMPLETED and aSquiresTestII == QUEST_COMPLETED then
            if toCureaCough == QUEST_ACCEPTED then
                player:startEvent(641)  -- reads page 3
            else
                player:startEvent(640)  -- reads page 2
            end
        elseif medicineWoman == QUEST_AVAILABLE and aSquiresTestII == QUEST_AVAILABLE then
            player:startEvent(641)      -- reads page 3
        else
            player:startEvent(640)      -- reads page 2
        end
    elseif diaryPage >= 3 then
        player:startEvent(722)          -- reads page 4
    --elseif diaryPage >= 4 then
    --    player:startEvent(723)        -- read last page
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local diaryPage = player:getCharVar("DiaryPage")

    if option >= diaryPage then
        if csid == 639 and option == 0 then
            player:setCharVar("DiaryPage", 1)    -- has read page 1
        elseif csid == 640 and option == 2 then
            player:setCharVar("DiaryPage", 2)    -- has read page 2
        elseif csid == 641 and option == 3 then
            player:setCharVar("DiaryPage", 3)    -- has read page 3
        elseif csid == 722 and option == 4 then
            player:setCharVar("DiaryPage", 4)    -- has read page 4
        --elseif csid == 723 and option == 5 then
        --    player:setCharVar("DiaryPage", 5)    -- has read the last page
        end
    end
end
