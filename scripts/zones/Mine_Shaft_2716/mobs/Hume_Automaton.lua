-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Hume Automaton
-- ENM: Automaton Assault
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)

    mob:timer(3000, function(mobArg)
        local race = mobArg:getBattlefield():getPlayers()[1]:getRace()
        if race == xi.race.HUME_M or race == xi.race.HUME_F then
            DespawnMob(mobArg:getID())
        elseif race == xi.race.TARU_M or race == xi.race.TARU_F then
            mobArg:setMod(xi.mod.UDMGMAGIC, -7500)
            mobArg:setMod(xi.mod.UDMGPHYS,   7500)
        elseif race == xi.race.MITHRA then
            mobArg:setMod(xi.mod.UDMGPHYS, -7500)
            mobArg:setMod(xi.mod.UDMGRANGE, 7500)
        elseif race == xi.race.GALKA then
            mobArg:setMod(xi.mod.UDMGPHYS, -7500)
            mobArg:setMod(xi.mod.UDMGMAGIC, 7500)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    if GetMobByID(mob:getID()+1):isAlive() then
        GetMobByID(mob:getID()+1):updateEnmity(player)
    else
        GetMobByID(mob:getID()+2):updateEnmity(player)
    end
end

return entity
