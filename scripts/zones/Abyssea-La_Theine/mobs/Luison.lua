-----------------------------------
-- Area: Abyssea - La Theine
--  Mob: Luison
-----------------------------------
mixins = { require("scripts/mixins/families/gnole") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
	  player:addCurrency('cruor', 250)
	  player:PrintToPlayer("You obtain 250 Cruor!", 0xD)
    end

return entity
