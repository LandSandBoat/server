-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Tarutaru Automaton
-- ENM: Automaton Assault
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.UDMGPHYS, 7500)
    mob:addMod(xi.mod.FASTCAST, 30);

    mob:timer(3000, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.TARU_M or race == xi.race.TARU_F then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if GetMobByID(mob:getID()+1):isAlive() then
        GetMobByID(mob:getID()+1):updateEnmity(player)
    else
        GetMobByID(mob:getID()+2):updateEnmity(player)
    end
end

return entity
