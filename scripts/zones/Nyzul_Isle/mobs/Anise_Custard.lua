-----------------------------------
--  MOB: Anise Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs ice elemental damage
-----------------------------------
mixins = { require('scripts/mixins/families/flan') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_ABSORB, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
