-----------------------------------
--  MOB: Nutmeg Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs earth elemental damage
-----------------------------------
mixins = { require('scripts/mixins/families/flan') }
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EARTH_ABSORB, 100)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
