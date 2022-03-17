-----------------------------------
-- Area: Lower Jeuno
--  NPC: Scrappy
-- CatsEyeXI Custom NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
   local stock =
   {
       3279,  15000,    -- Neptunal tatter
       3280,  15000,    -- Martial tatter 
       3281,  15000,    -- Earthen tatter
       3282,  15000,    -- Dryadic tatter
	   3283,  15000,    -- Aquarian tatter
	   3284,  15000,    -- Wyrmal tatter
	   3285,  25000,    -- Phantasmal tatter
	   3286,  25000,    -- Hadean tatter
	   3275,  25000,	 -- Genbu scrap
	   3276,  25000,	 -- Suzaku scrap
	   3277,  25000,	 -- Seiryu scrap
	   3278,  25000,	 -- Byakko scrap
	
   }
    
	player:PrintToPlayer("Scrappy: for a limited time only, you can buy scraps and tatters from Sccrrraappy!", 0xD)
    xi.shop.general(player, stock, SANDORIA)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
