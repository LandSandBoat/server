-----------------------------------
-- Area: Temenos
--  Mob: Aerns_Avatar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
