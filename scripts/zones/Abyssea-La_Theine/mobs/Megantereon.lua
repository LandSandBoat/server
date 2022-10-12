-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/npc_util")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    
	if math.random(100) <= 100	then -- 100% chance For KI drop
      npcUtil.giveKeyItem(player, xi.ki.BLOODIED_SABER_TOOTH)
    end
	  player:addCurrency('cruor', 250)
	  player:PrintToPlayer("You obtain 250 Cruor!", 0xD)
    end

return entity