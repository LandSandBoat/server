-----------------------------------
-- Area: Davoi
-- NPC: ??? (qm2)
-- Involved in Quest: Tea with a Tonberry
-- !pos 189.201 1.2553 -383.921 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
	if player:getCharVar('TEA_WITH_A_TONBERRY_PROG') == 3 then
		if npcUtil.tradeHas(trade, 1682) and npcUtil.popFromQM(player, npc, ID.mob.HEMATIC_CYST) then -- Treasury Gold spawns Hematic Cyst
			player:messageSpecial(ID.text.ON_NM_SPAWN)
			player:confirmTrade()
		end
	end
end

function onTrigger(player, npc)
	if player:getCharVar('TEA_WITH_A_TONBERRY_PROG') == 4 then
		player:startEvent(126, 149, 1682)
	end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
	if csid == 126 then
		player:setCharVar('TEA_WITH_A_TONBERRY_PROG', 5)
	end
end
