-----------------------------------
-- Area: Windurst Woods
--  NPC: Spare Three
-- Working 100%
--  Involved in quest: A Greeting Cardian
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local AGreetingCardian = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
    local AGCcs = player:getCharVar("AGreetingCardian_Event")

    if AGreetingCardian == QUEST_ACCEPTED and AGCcs == 2 then
        player:startEvent(295) -- A Greeting Cardian step two
    else
        player:startEvent(280) -- standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 295 then
        player:setCharVar("AGreetingCardian_Event", 3)
    end
end
