-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Devil Manta (Fished)
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar("lastTOD", os.time())
end

return entity
