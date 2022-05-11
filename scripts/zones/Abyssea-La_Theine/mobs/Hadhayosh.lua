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
      npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_CRIMSON)
	end
	  if math.random(100) <= 100	then -- 100% chance For KI drop
      npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_FUCHSIA)
	end

	  player:addCurrency('cruor', 1000)
	  player:PrintToPlayer("You obtain 1000 Cruor!", 0xD)
    end

return entity
