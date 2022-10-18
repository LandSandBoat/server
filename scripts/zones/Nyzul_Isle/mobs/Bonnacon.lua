-----------------------------------
--  MOB: Bonnacon
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require('scripts/globals/nyzul')
require('scripts/globals/additional_effects')
require('scripts/globals/status')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 50, duration = math.random(4, 8) })
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
