-----------------------------------
-- Area: Windurst Walls
--  NPC: Hiwon-Biwon
--  Involved In Quest: Making Headlines, Curses, Foiled...Again!?
-- Working 100%
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Windurst_Walls/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local MakingHeadlines = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    local CFA2 = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_2)

    -- Curses, Foiled ... Again!?
    if (CFA2 == QUEST_ACCEPTED and player:hasItem(552) == false) then
        player:startEvent(182) -- get Hiwon's hair
    elseif (CFA2 == QUEST_COMPLETED and MakingHeadlines ~= QUEST_ACCEPTED) then
        player:startEvent(185) -- New Dialog after CFA2

    -- Making Headlines
    elseif (MakingHeadlines == 1) then
        prog = player:getCharVar("QuestMakingHeadlines_var")
        --  Variable to track if player has talked to 4 NPCs and a door
        --  1 = Kyume
        -- 2 = Yujuju
        -- 4 = Hiwom
        -- 8 = Umumu
        -- 16 = Mahogany Door
        if (testflag(tonumber(prog), 4) == false) then
            if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CURSES_FOILED_AGAIN_1) == 1) then
                if (math.random(1, 2) == 1) then
                    player:startEvent(283) -- Give scoop while sick
                else
                    player:startEvent(284) -- Give scoop while sick
                end
            else
                player:startEvent(281) -- Give scoop
            end
        else
            player:startEvent(282) -- "Getting back to the maater at hand-wand..."
        end
    else
        local rand = math.random(1, 5)
        if (rand == 1) then
            print (rand)
            player:startEvent(305) -- Standard Conversation
        elseif (rand == 2) then
            print (rand)
            player:startEvent(306) -- Standard Conversation
        elseif (rand == 3) then
            print (rand)
            player:startEvent(168) -- Standard Conversation
        elseif (rand == 4) then
            print (rand)
            player:startEvent(170) -- Standard Conversation
        elseif (rand == 5) then
            print (rand)
            player:startEvent(169) -- Standard Conversation
        end
    end
end

function onEventUpdate(player, csid, option)

end

function onEventFinish(player, csid, option)

    -- Making Headlines
    if (csid == 281 or csid == 283 or csid == 284) then
        prog = player:getCharVar("QuestMakingHeadlines_var")
        player:addKeyItem(tpz.ki.WINDURST_WALLS_SCOOP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WINDURST_WALLS_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", prog+4)

    -- Curses, Foiled...Again!?
    elseif (csid == 182) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 552) -- Hiwon's hair
        else
            player:addItem(552)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 552) -- Hiwon's hair
        end
    end
end
