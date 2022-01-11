-- Mangy-tailed Marvin
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/chocobo");
require("scripts/globals/keyitems");
require("scripts/globals/status");
require("scripts/globals/npc_util")
require("scripts/globals/shop")
-----------------------------------
local entity = {}
entity.onMobDeath = function(mob, player, isKiller)
	
if player:getCharVar("bunny", 1) then
local bunny = mob:getID()
GetMobByID(bunny):setDropID(3172)
	end
end
return entity
