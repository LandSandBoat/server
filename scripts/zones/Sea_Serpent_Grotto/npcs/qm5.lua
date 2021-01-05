-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: qm1 (???)
-- Quests: An Undying Pledge
-- !pos 135x -9y 220z
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
	if player:getCharVar("pledgeCS") == 2 and player:getCharVar("pledgeNM_killed") == 1 then
		player:startEvent(18)
	elseif player:getCharVar("pledgeCS") == 2 and player:getCharVar("pledgeNM_killed") == 0 then
		npcUtil.popFromQM(player, npc, ID.mob.GLYRYVILU, {claim=true, hide=0})
		player:messageSpecial(ID.text.BODY_NUMB_DREAD)
	else
		player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end
