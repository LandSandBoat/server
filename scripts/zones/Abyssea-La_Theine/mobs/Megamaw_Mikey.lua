-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/npc_util")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
	  player:addCurrency('cruor', 150)
	  player:PrintToPlayer("You obtain 150 Cruor!", 0xD)
    end


return entity