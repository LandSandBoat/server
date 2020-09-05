-----------------------------------
-- Area: Windurst Walls
--  Location: X:-90  Y:-9  Z:109
--  NPC: Kalupa-Tawalupa
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
        player:startEvent(66) -- During Too Bee quest before honey given to Zayhi: "are you alright sir"
    elseif (ToBee == QUEST_ACCEPTED and ToBeeOrNotStatus > 0) then
            player:startEvent(72) -- During Too Bee quest after some honey was given to Zayhi: "hey did that honey help you just now?"
    elseif (ToBee == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(77) -- After Too Bee quest but before zone: "well I guess a tooth ache is to be expected"
    else
        player:startEvent(298) -- Normal conversation
    end
end

-- CS/Event ID List for NPC
-- *CS 443 - player:startEvent(443) -- Long Star Sybil CS
-- CS 298 - player:startEvent(298) -- Normal conversation
-- *CS 64 - player:startEvent(64) -- Zayhi Coughing
-- CS 66 - player:startEvent(66) -- During Too Bee quest before honey given to Zayhi: "are you alright sir"
-- CS 72 - player:startEvent(72) -- During Too Bee quest after some honey was given to Zayhi: "hey did that honey help you just now?"
-- *CS 75 - player:startEvent(75) -- Combo CS: During Too Bee quest, kicked off from Zayhi
-- CS 77 - player:startEvent(77) -- After Too Bee quest but before zone: "well I guess a tooth ache is to be expected"
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
