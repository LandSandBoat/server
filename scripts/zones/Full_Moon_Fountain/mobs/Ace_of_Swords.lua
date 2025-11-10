-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ace of Swords
-- Windurst Mission 9-2
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
