-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Tarutaru Automaton
-- ENM: Automaton Assault
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.UDMGPHYS, 7500)
    mob:addMod(xi.mod.FASTCAST, 30);
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)

    mob:timer(1, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.TARU_M or race == xi.race.TARU_F then
            DespawnMob(mobArg:getID())
        end
    end)

    mob:addListener("DEATH", "TARU_AUTOMATON_DEATH", function(mobArg, killer)
        if GetMobByID(mobArg:getID()+1):isAlive() then
            GetMobByID(mobArg:getID()+1):updateEnmity(killer)
        else
            GetMobByID(mobArg:getID()+2):updateEnmity(killer)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
