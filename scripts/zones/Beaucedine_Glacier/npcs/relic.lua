-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: <this space intentionally left blank>
-- !pos -89 0 -374 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.VALHALLA and npcUtil.tradeHas(trade, {xi.items.RANPERRE_GOLDPIECE, xi.items.INTRICATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.VALHALLA})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(139, xi.items.RAGNAROK)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("RelicWeaponVoucher") == 1 then
	    player:setCharVar("RelicWeaponVoucher", 0)
--	    player:setCharVar("RelicWeaponVoucherUsed") == 1
        player:addItem(xi.items.RAGNAROK) 
    	player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.RAGNAROK)
		return
	end	
	
    player:PrintToPlayer("???: Hail to you hardened traveler,", 0xD)
    player:PrintToPlayer("???: Do you desire to switch your ally? Trade your relic back to me together with 5,000,000 gil", 0xD)
	player:PrintToPlayer("???: and I'll exchange it for my soul. Let me return to the battlefield!", 0xD)
    -- player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 139 and npcUtil.giveItem(player, {xi.items.RAGNAROK, {xi.items.MONTIONT_SILVERPIECE, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
