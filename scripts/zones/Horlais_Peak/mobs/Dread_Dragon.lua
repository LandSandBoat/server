-----------------------------------
-- Area: Horlais Peak
--  Mob: Dread Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DREAD_DRAGON_SLAYER)
end

return entity
