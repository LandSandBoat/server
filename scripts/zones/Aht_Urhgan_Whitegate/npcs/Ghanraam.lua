-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghanraam
-- Type: "Nyzul Weapon/Salvage Armor Storer, "
-- !pos 108.773 -6.999 -51.297 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/utils")

local entity = {}

entity.onTrade = function(player, npc, trade)
    local orichalcumIngots = npcUtil.tradeHas(trade, {{ 747, 6 }})
    local wootzIngots = npcUtil.tradeHas(trade, {{ 686, 6 }})
    local bloodwoodLumber = npcUtil.tradeHas(trade, {{ 730, 6 }})
    local wamouraCloth = npcUtil.tradeHas(trade, {{ 2289, 6 }})
    local maridLeather = npcUtil.tradeHas(trade, {{ 2152, 6 }})
	local imperialGoldPieces = npcUtil.tradeHas(trade, {{2187, 10}})

    -- Start Fun Stuff

    local freeInventory = player:getFreeSlotsCount()
	
	if (freeInventory > 1) then 

    	if npcUtil.tradeHas(trade, 16085, 16086, 16087) and orichalcumIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(16084)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 16084)
    	end
    
    	if npcUtil.tradeHas(trade, 14547, 14548, 14549) and wootzIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14546)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14546)
    	end
    
    	if npcUtil.tradeHas(trade, 14962, 14963, 14964) and bloodwoodLumber and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14961)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14961)
    	end
    
    	if npcUtil.tradeHas(trade, 15626, 15627, 15628) and wamouraCloth and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15625)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15625)
    	end
    
    	if npcUtil.tradeHas(trade, 15712, 15713, 15714) and maridLeather and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15711)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15711)
    	end
    
        -- End Ares' Armor
    
    	if npcUtil.tradeHas(trade, 16089, 16090, 16091) and orichalcumIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(16088)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 16088)
    	end
    
    	if npcUtil.tradeHas(trade, 14551, 14552, 14553) and wootzIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14550)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14550)
    	end
    
    	if npcUtil.tradeHas(trade, 14966, 14967, 14968) and bloodwoodLumber and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14965)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14965)
    	end
    
    	if npcUtil.tradeHas(trade, 15630, 15631, 15632) and wamouraCloth and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15629)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15629)
    	end
    
    	if npcUtil.tradeHas(trade, 15716, 15717, 15718) and maridLeather and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15715)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15715)
    	end
    
        -- End Skadi's Attire
    
    	if npcUtil.tradeHas(trade, 16093, 16094, 16095) and orichalcumIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(16092)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 16092)
    	end
    
    	if npcUtil.tradeHas(trade, 14555, 14556, 14557) and wootzIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14554)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14554)
    	end
    
    	if npcUtil.tradeHas(trade, 14970, 14971, 14972) and bloodwoodLumber and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14969)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14969)
    	end
    
    	if npcUtil.tradeHas(trade, 15634, 15635, 15636) and wamouraCloth and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15633)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15633)
    	end
    
    	if npcUtil.tradeHas(trade, 15720, 15721, 15722) and maridLeather and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15719)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15719)
    	end
    
        -- End Usukane Attire
    
    	if npcUtil.tradeHas(trade, 16097, 16098, 16099) and orichalcumIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(16096)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 16096)
    	end
    
    	if npcUtil.tradeHas(trade, 14559, 14560, 14561) and wootzIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14558)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14558)
    	end
    
    	if npcUtil.tradeHas(trade, 14974, 14975, 14976) and bloodwoodLumber and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14973)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14973)
    	end
    
    	if npcUtil.tradeHas(trade, 15638, 15639, 15640) and wamouraCloth and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15637)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15637)
    	end
    
    	if npcUtil.tradeHas(trade, 15724, 15725, 15726) and maridLeather and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15723)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15723)
    	end
    	
    	-- End Marduk's Attire	
    
    	if npcUtil.tradeHas(trade, 16101, 16102, 16103) and orichalcumIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(16100)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 16100)
    	end
    
    	if npcUtil.tradeHas(trade, 14563, 14564, 14565) and wootzIngots and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14562)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14562)
    	end
    
    	if npcUtil.tradeHas(trade, 14978, 14979, 14980) and bloodwoodLumber and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(14977)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 14977)
    	end
    
    	if npcUtil.tradeHas(trade, 15642, 15643, 15644) and wamouraCloth and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15641)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15641)
    	end
    
    	if npcUtil.tradeHas(trade, 15728, 15729, 15730) and maridLeather and imperialGoldPieces then
		    player:tradeComplete()
    		player:addItem(15727)
    	    player:messageSpecial(ID.text.ITEM_OBTAINED, 15727)
    	end
    
    -- End Morrigan's Attire

    else
	    player:PrintToPlayer("Ghanraam: Please return after sorting your inventory", 0xD)

    end

end

entity.onTrigger = function(player, npc)
    player:startEvent(893)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
