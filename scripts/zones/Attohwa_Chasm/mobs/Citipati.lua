-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
