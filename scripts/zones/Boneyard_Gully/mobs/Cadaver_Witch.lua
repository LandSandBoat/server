-----------------------------------
-- Area: Boneyard Gully
-- Mob: Cadaver Witch
-- ENM: Totentanz
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_DESPAWN))
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.LULLABYRES, 70)
    mob:setMod(xi.mod.SILENCERES, 70)
    mob:setMod(xi.mod.BINDRES, 70)
end

entity.onMobSpawn = function(mob)
    mob:timer(1, function(mobArg)
        if mobArg:getBattlefield():getLocalVar("undeadControl") == 0 then
            mobArg:setHP(0)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:hideName(true)
end

return entity
