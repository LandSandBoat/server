-----------------------------------
-- Area: Windurst Woods
--   NPC: Bopa Greso
-- Type: Standard NPC
-- !pos 59.773 -6.249 216.766 241
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local thickAsThieves = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES)
    local thickAsThievesCS = player:getCharVar("thickAsThievesCS")

    if thickAsThieves == QUEST_ACCEPTED then
        player:startEvent(506)
        if thickAsThievesCS == 1 then
            player:setCharVar("thickAsThievesCS", 2)
        elseif thickAsThievesCS == 3 then
            player:setCharVar("thickAsThievesCS", 4)
            local rand1 = math.random(2, 7)
            player:setCharVar("thickAsThievesGrapplingCS", rand1)
            player:setCharVar("thickAsThievesGamblingCS", 1)
        end
    else
        player:startEvent(77) -- standard cs
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
