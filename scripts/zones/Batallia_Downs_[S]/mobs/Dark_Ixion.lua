-----------------------------------
-- Area: Batallia_Downs_[S]
--  Mob: Dark Ixion
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.IXION_HORNBREAKER)
end

return entity
