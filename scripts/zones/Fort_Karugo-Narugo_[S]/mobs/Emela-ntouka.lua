-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Emela-ntouka
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- The value below is estimated based on another example in the code
    -- where the mob 'Seemed to have very high TP gain.'
    mob:setMod(xi.mod.REGAIN, 200)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
end

entity.onMobSpawn = function(mob)
    -- Mob uses blockhead exclusively, twice, back-to-back
    mob:addListener('WEAPONSKILL_USE', 'DOUBLE_BLOCKHEAD', function(mobArg, target, wsid, tp, action)
        local reuseMobskill = mob:getLocalVar('reuseMobskill')

        if reuseMobskill == 0 then
            mob:setLocalVar('reuseMobskill', 1)
            mob:setTP(3000)
            mob:useMobAbility(wsid)
        else
            mob:setLocalVar('reuseMobskill', 0)
        end
    end)

    mob:setRespawnTime(0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 521)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('DOUBLE_BLOCKHEAD')

    -- Do not respawn for 3-4 hours
    mob:setRespawnTime(math.random(10800, 14400))
    mob:resetLocalVars()
end

return entity
