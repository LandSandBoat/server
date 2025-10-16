-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Tatzlwurm
-- Windurst Mission 9-2
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
