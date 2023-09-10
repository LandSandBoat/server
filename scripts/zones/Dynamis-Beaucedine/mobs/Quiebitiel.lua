-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Quiebitiel
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2660, 2684, 2715 })
end

return entity
