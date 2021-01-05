-----------------------------------
-- Area: Norg
--  NPC: Stray Cloud
-- Starts and Ends Quest: An Undying Pledge
-- !pos-20.617, 1.097, -29.165, 133
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    Pledge = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.AN_UNDYING_PLEDGE) 	

    if (Pledge == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 4) then
        player:startEvent(225) -- Start quest
	elseif (Pledge == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CALIGINOUS_BLADE)) then
		player:startEvent(227) -- Quest Finish
	elseif (Pledge == QUEST_ACCEPTED) and player:getCharVar("pledgeCS") == 1 then	
	    player:startEvent(228) -- Extra Dialogue
	elseif (Pledge == QUEST_ACCEPTED) and player:getCharVar("pledgeCS") == 2 then
		player:startEvent(229) -- Extra Dialogue
	elseif (Pledge == QUEST_COMPLETED) then
		player:startEvent(230)
	else
        player:startEvent(231) -- Standard Conversation
	end

end 


function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
	if (csid == 225) then
		player:addQuest(OUTLANDS, tpz.quest.id.outlands.AN_UNDYING_PLEDGE)
		player:setCharVar("pledgeCS", 1)
	elseif (csid == 227) then
		if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12375)
		else
            player:delKeyItem(tpz.ki.CALIGINOUS_BLADE)
            player:addItem(12375) -- Light Buckler
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12375)
            player:addFame(NORG, 50)
			player:setCharVar("pledgeCS", 0)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.AN_UNDYING_PLEDGE)
        end
	end

end
