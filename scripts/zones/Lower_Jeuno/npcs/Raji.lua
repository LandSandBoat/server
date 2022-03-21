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
--[[   local stock =
   {
       3279,  35000,    -- Neptunal tatter
       3280,  35000,    -- Martial tatter 
       3281,  35000,    -- Earthen tatter
       3282,  35000,    -- Dryadic tatter
	   3283,  35000,    -- Aquarian tatter
	   3284,  35000,    -- Wyrmal tatter
	   3285,  45000,    -- Phantasmal tatter
	   3286,  45000,    -- Hadean tatter
	   3275,  45000,	 -- Genbu scrap
	   3276,  45000,	 -- Suzaku scrap
	   3277,  45000,	 -- Seiryu scrap
	   3278,  45000,	 -- Byakko scrap
	
   }
--]]    
	player:PrintToPlayer("Scrappy: Scrappy go bye-bye.", 0xD)
--    xi.shop.general(player, stock, SANDORIA)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
