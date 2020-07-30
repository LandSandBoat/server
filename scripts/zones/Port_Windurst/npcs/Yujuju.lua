-----------------------------------
-- Area: Port Windurst
--  NPC: Yujuju
--  Involved In Quest: Making Headlines
-- !pos 201.523 -4.785 138.978 240
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local MakingHeadlines = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 19) == false) then
        player:startEvent(621)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")==9) then
        player:startEvent(592)--COP event
    elseif (MakingHeadlines == 1) then
        local prog = player:getCharVar("QuestMakingHeadlines_var")
        --  Variable to track if player has talked to 4 NPCs and a door
        --  1 = Kyume
        -- 2 = Yujuju
        -- 4 = Hiwom
        -- 8 = Umumu
        -- 16 = Mahogany Door
        if (testflag(tonumber(prog), 2) == false) then
            player:startEvent(314) -- Get Scoop
        else
            player:startEvent(315) -- After receiving scoop
        end
    else
        player:startEvent(340) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 314) then
        prog = player:getCharVar("QuestMakingHeadlines_var")
        player:addKeyItem(tpz.ki.PORT_WINDURST_SCOOP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PORT_WINDURST_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", prog+2)
    elseif (csid == 592)    then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 10)
    elseif (csid == 621) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 19, true)
    end
end
