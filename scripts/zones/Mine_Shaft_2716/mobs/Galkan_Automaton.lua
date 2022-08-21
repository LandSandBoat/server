-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Galkan Automaton
-- ENM: Automaton Assault
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -7500)
    mob:setMod(xi.mod.UDMGMAGIC, 7500)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)

    mob:timer(1, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.GALKA then
            DespawnMob(mobArg:getID())
        else

        end
    end)

    mob:addListener("TAKE_DAMAGE", "AUTOMATON_TAKE_DAMAGE", function(mobArg, amount, attacker)
        if amount > mobArg:getHP() then
            if GetMobByID(mobArg:getID()-4):isAlive() then
                GetMobByID(mobArg:getID()-4):updateEnmity(attacker)
            else
                GetMobByID(mobArg:getID()-3):updateEnmity(attacker)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
