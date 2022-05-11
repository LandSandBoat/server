-----------------------------------
--  Mob: Carabosse
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
      npcUtil.giveKeyItem(player, xi.ki.GLITTERING_PIXIE_CHOKER)
    end
	if math.random(100) <= 100	then -- 100% chance For KI drop
	npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_EMERALD)
	end
	  player:addCurrency('cruor', 500)
	  player:PrintToPlayer("You obtain 500 Cruor!", 0xD)
    end

return entity