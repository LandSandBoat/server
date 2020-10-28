-----------------------------------
-- Area: Davoi
--  NPC: ??? (qm2)
-- Involved in Quest: Tea with a Tonberry
-- !pos 189.201 1.2553 -383.921
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/npcutil")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
teaProg = player:getCharVar(	)
    if teaProg == 3 then
    	if npcUtil.tradeHas(trade, 1682) and npcUtil.popFromQM(player, npc, ID.mob.HEMATIC_CYST) then -- Treasury Gold spawns Hematic Cyst
        	player:messageSpecial(ID.text.ON_NM_SPAWN)
        	player:confirmTrade()
    	end
    elseif teaProg = 4 then
    	player:startEvent(126)
    end
end


function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
