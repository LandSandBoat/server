-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Mithran Automaton
-- ENM: Automaton Assault
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMod(xi.mod.UDMGPHYS, -7500)
    mob:setMod(xi.mod.UDMGRANGE, 7500)

    mob:timer(3000, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.MITHRA then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    if GetMobByID(mob:getID()+1):isAlive() then
        GetMobByID(mob:getID()+1):updateEnmity(player)
    else
        GetMobByID(mob:getID()-3):updateEnmity(player)
    end
end

return entity
