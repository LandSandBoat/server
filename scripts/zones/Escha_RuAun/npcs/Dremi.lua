-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
local GodsWin = (player:getCharVar("[Eschan]Byakko") == 1) and (player:getCharVar("[Eschan]Suzaku") == 1) and
				(player:getCharVar("[Eschan]Genbu") == 1) and (player:getCharVar("[Eschan]Seiryu") == 1) 
				
    if player:hasKeyItem(xi.keyItem.CERULEAN_CRYSTAL) then
        for i = 0, 2 do
		    if player:getRank(i) >= 10 then
			    printf(string.format("%s", i))
        	    if npcUtil.tradeHas(trade, {{ 3277, 3 }}) then
        	        player:tradeComplete()
                	npcUtil.giveKeyItem(player, xi.keyItem.SEIRYUS_NOBILITY)
                end
                if npcUtil.tradeHas(trade, {{ 3276, 3 }}) then
        	        player:tradeComplete()
                	npcUtil.giveKeyItem(player, xi.keyItem.SUZAKUS_BENEFACTION)
                end
                if npcUtil.tradeHas(trade, {{ 3278, 3 }}) then
        	        player:tradeComplete()
                	npcUtil.giveKeyItem(player, xi.keyItem.BYAKKOS_PRIDE)
                end
                if npcUtil.tradeHas(trade, {{ 3275, 3 }}) then
        	        player:tradeComplete()
                	npcUtil.giveKeyItem(player, xi.keyItem.GENBUS_HONOR)
                end       
        		if npcUtil.tradeHas(trade, 1404, 1405, 1406, 1407) and GodsWin then
        		   player:tradeComplete()
        		   npcUtil.giveKeyItem(player, xi.keyItem.KIRINS_FERVOR)
        		end
				break
            end
		end
	end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.keyItem.CERULEAN_CRYSTAL) then
        for i = 0, 3 do 
		    if player:getRank(i) >= 10 then
    			player:PrintToPlayer("Dremi: My, oh my! Look at those muscles...", xi.msg.channel.NS_SAY)
	   
	            player:timer(1000, function(playerArg)
	                player:PrintToPlayer("You begin feeling like a piece of meat as Dremi looks you up and down...", xi.msg.channel.UNKNOWN_32)
	            end)
	        	
	            player:timer(4000, function(playerArg)
	                player:PrintToPlayer("Dremi: You're going to do just fine here, darling... Trade me scraps to get started.", xi.msg.channel.NS_SAY)
	            end)
	        
            else
                player:PrintToPlayer("You are not yet prepared to tackle these challenges!", xi.msg.channel.NS_SAY)
            end
			break
		end
	end	
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

end

return entity