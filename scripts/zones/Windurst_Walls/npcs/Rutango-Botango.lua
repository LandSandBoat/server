-----------------------------------
-- Area: Windurst Walls
--  Location: X:-92  Y:-9  Z:107
--  NPC: Rutango-Botango
-- Working 100%
--  Involved in Quest: To Bee or Not to Bee?
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ToBee = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
    local ToBeeOrNotStatus = player:getCharVar("ToBeeOrNot_var")

    if (ToBeeOrNotStatus == 10) then
        player:startEvent(65) -- During Too Bee quest before honey given to Zayhi:  "Oh Crumb...lost his voice"
    elseif (ToBee == QUEST_ACCEPTED and ToBeeOrNotStatus > 0) then
        player:startEvent(71) -- During Too Bee quest after some honey was given to Zayhi: "lap up more honey"
    elseif (ToBee == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(76) -- After Too Bee quest but before zone: "master let me speak for you"
    else
        player:startEvent(297) -- Standard Conversation
    end
end

-- CS/Event ID List for NPC
-- *Rutango-Botango    CS 443 - player:startEvent(443) -- Long Star Sybil CS
-- Rutango-Botango    CS 297 - player:startEvent(297) -- Standard Conversation
-- *Rutango-Botango    CS 64 - player:startEvent(64) -- Zayhi Coughing
-- Rutango-Botango    CS 65 - player:startEvent(65) -- During Too Bee quest before honey given to Zayhi:  "Oh Crumb...lost his voice"
-- Rutango-Botango    CS 71 - player:startEvent(71) -- During Too Bee quest after some honey was given to Zayhi: "lap up more honey"
-- *Rutango-Botango    CS 75 - player:startEvent(75) -- Combo CS: During Too Bee quest, kicked off from Zayhi
-- Rutango-Botango    CS 76 - player:startEvent(76) -- After Too Bee quest but before zone: "master let me speak for you"
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
