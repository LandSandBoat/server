-----------------------------------
--  MOB: Ginger Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs fire elemental damage, Highly resistant to silence, Gains regain at 50% HP
-----------------------------------
mixins = { require('scripts/mixins/families/flan') }
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    mob:setMod(xi.mod.SILENCE_MEVA, 80)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("Regain") == 0 then
        if mob:getHPP() <= 50 then
            mob:setMod(xi.mod.REGAIN, 100)
            mob:setLocalVar("Regain", 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
