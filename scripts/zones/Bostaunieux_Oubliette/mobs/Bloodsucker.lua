-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Bloodsucker
-- Note: The NM has a different lua name as Bloodsucker_NM
-- !pos -21.776 16.983 -231.477 167
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 613, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
end

return entity
