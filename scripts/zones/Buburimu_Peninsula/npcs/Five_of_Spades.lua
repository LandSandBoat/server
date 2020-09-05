-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Five of Spades
--  Invloved in quests: A Greeting Cardian
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local AGreetingCardian = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)
    local AGCcs = player:getCharVar("AGreetingCardian_Event")

    if (AGreetingCardian == QUEST_ACCEPTED and AGCcs == 4) then
        player:startEvent(1) -- A Greeting Cardian step three
    else
        player:showText(npc, ID.text.FIVEOFSPADES_DIALOG) -- Standard Dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1) then
        player:setCharVar("AGreetingCardian_Event", 5)
    end
end
