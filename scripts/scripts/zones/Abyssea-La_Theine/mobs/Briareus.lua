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
      npcUtil.giveKeyItem(player, xi.ki.BLOOD_SMEARED_GIGAS_HELM)
    end
	if math.random(100) <= 100	then -- 100% chance For KI drop
      npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_MAUVE)
	end
	  player:addCurrency('cruor', 500)
	  player:PrintToPlayer("You obtain 500 Cruor!", 0xD)
    end

return entity