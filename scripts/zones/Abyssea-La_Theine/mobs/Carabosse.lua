-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'phuabo
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}
entity.onMobDeath = function(mob, player, isKiller)
    
	if math.random(100) <= 100	then -- 100% chance For KI drop
      npcUtil.giveKeyItem(player, xi.ki.GLITTERING_PIXIE_CHOKER)
    end
	if math.random(100) <= 100	then -- 100% chance For KI drop
	npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_EMERALD)
	end
end
return entity
