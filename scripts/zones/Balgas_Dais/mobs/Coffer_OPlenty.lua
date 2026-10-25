-----------------------------------
-- Area: Balga's Dais
--  Mob: Coffer O'Plenty
-- A.M.A.N. Trove (Venus Orb)
-----------------------------------
mixins = { require('scripts/mixins/families/mimic') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.amanTrove.onChestSpawn(mob)
end

entity.onTrigger = function(player, mob)
    xi.amanTrove.onChestTrigger(player, mob)
end

entity.onMobEngage = function(mob, target)
    xi.amanTrove.onChestEngage(mob, target)
end

entity.onMobFight = function(mob, target)
    xi.amanTrove.onMimicFight(mob, target)
end

entity.onMobDisengage = function(mob)
    xi.amanTrove.onMimicDisengage(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.amanTrove.onMimicDeath(mob, player, optParams)
end

return entity
