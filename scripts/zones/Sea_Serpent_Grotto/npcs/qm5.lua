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
<<<<<<< Updated upstream
	if player:getCharVar("pledgeCS") == 2 and player:getCharVar("pledgeNM_killed") == 1 then
		player:startEvent(18)
	elseif player:getCharVar("pledgeCS") == 2 and player:getCharVar("pledgeNM_killed") == 0 then
		npcUtil.popFromQM(player, npc, ID.mob.GLYRYVILU, {claim=true, hide=0})
		player:messageSpecial(ID.text.BODY_NUMB_DREAD)
	else
		player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
	end
end
=======
    if player:getCharVar("anUndyingPledgeCS") == 2 and player:getCharVar("anUndyingPledgeNM_killed") == 1 then
        player:startEvent(18)
    elseif 
        player:getCharVar("anUndyingPledgeCS") == 2 and 
        player:getCharVar("anUndyingPledgeNM_killed") == 0 and
        npcUtil.popFromQM(player, npc, ID.mob.GLYRYVILU, {hide=0}) 
    then
        player:messageSpecial(ID.text.BODY_NUMB_DREAD)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end


function onEventFinish(player, csid, option)
    if (csid == 18) then
        player:addKeyItem(tpz.ki.CALIGINOUS_BLADE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CALIGINOUS_BLADE)
        player:setCharVar("anUndyingPledgeCS", 3)
        player:setCharVar("anUndyingPledgeNM_killed", 0)
    end
end
>>>>>>> Stashed changes
