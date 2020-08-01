-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: Mahogany Door
--  Involved In Quest: Making Headlines
-- Working 100%
--  Unable to find EventID for Making Headlines quest. Used dialog ID instead.
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    --[[
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local MakingHeadlines = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)

    if MakingHeadlines == 1 then
        local prog = player:getCharVar("QuestMakingHeadlines_var")

        if testflag(tonumber(prog), 16) == false and testflag(tonumber(prog), 8) then
            player:messageSpecial(7208, 1, tpz.ki.WINDURST_WOODS_SCOOP) -- Confirm Story
            player:setCharVar("QuestMakingHeadlines_var", prog + 16)
        else
            player:startEvent(44) -- "The door is firmly shut"
        end
    else
        player:startEvent(44) -- "The door is firmly shut"
    end
    --]]
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
