-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Greater Cockatrice
-- Note: Place Holder for Pelican
-----------------------------------
mixins = { require('scripts/mixins/families/cockatrice') }
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice.onMobWeaponSkill(mob, target, skill)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 741, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PELICAN, 10, 14400) -- 4 hours
end

return entity
