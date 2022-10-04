-----------------------------------
-- Area: Boneyard Gully
-- Mob: Cadaver Warrior
-- ENM: Totentanz
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_DESPAWN))
    mob:setMod(xi.mod.LULLABYRES, 70)
    mob:setMod(xi.mod.BINDRES, 70)

    mob:timer(3000, function(mobArg)
        if mobArg:getBattlefield():getLocalVar("undeadControl") == 0 then
            mobArg:setHP(0)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:hideName(true)
end

return entity
