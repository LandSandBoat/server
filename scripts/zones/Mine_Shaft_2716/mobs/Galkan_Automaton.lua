-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Galkan Automaton
-- ENM: Automaton Assault
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMod(xi.mod.UDMGPHYS, -7500)
    mob:setMod(xi.mod.UDMGMAGIC, 7500)

    mob:timer(3000, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.GALKA then
            DespawnMob(mobArg:getID())
        else

        end
    end)

    mob:addListener("DEATH", "GALKAN_AUTOMATON_DEATH", function(automaton, killer)
        if GetMobByID(automaton:getID()-4):isAlive() then
            GetMobByID(automaton:getID()-4):updateEnmity(killer)
        else
            GetMobByID(automaton:getID()-3):updateEnmity(killer)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
