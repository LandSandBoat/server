-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Dark Ixion
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.IXION_HORNBREAKER)
end

return entity
