-----------------------------------
-- Area: Throne Room
--  Mob: Zeid (Phase 2)
-- Bastok mission 9-2 BCNM Fight (Phase 2)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.REGAIN, 300)
    mob:setMobMod(xi.mobMod.NO_REST, 1)

    -- 50% chance to immediately TP move again (but only once per chain)
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'ZEID_TP_CHAIN', function(mobEntity, skillID)
        local justChained = mobEntity:getLocalVar('justChained')

        -- Only allow chaining if this wasn't already a chained TP move
        if justChained == 0 and math.random(1, 100) <= 50 then
            mobEntity:setTP(3000)
            mobEntity:setLocalVar('justChained', 1) -- Mark this as a chained TP
        else
            -- Reset the chained flag for next potential chain
            mobEntity:setLocalVar('justChained', 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('petSpawnPercent', math.random(50, 90))
    xi.mix.jobSpecial.config(mob,
        {
            specials =
            {
                { id = xi.jsa.BLOOD_WEAPON, hpp = math.random(20, 50) },
            },
        })
end

entity.onMobFight = function(mob, target)
    local zeid             = mob:getID()
    local shadow1          = GetMobByID(zeid + 1)
    local shadow2          = GetMobByID(zeid + 2)
    local initialSpawnDone = mob:getLocalVar('initialSpawnDone')

    -- Initial check for HPP based spawn, then respawn based on timer if a shadow dies
    if initialSpawnDone == 0 and mob:getHPP() <= mob:getLocalVar('petSpawnPercent') then
        mob:useMobAbility(xi.mobSkill.ZEID_SUMMON_SHADOWS_2, nil, 0)
        mob:setLocalVar('initialSpawnDone', 1)
    elseif
        initialSpawnDone == 1 and
        mob:getLocalVar('petRespawnTime') ~= 0 and
        GetSystemTime() >= mob:getLocalVar('petRespawnTime') and
        (shadow1 and shadow1:isDead() or shadow2 and shadow2:isDead())
    then
        mob:useMobAbility(xi.mobSkill.ZEID_SUMMON_SHADOWS_2, nil, 0)
        -- Clear the timer to prevent re-summoning until a shadow dies again
        mob:setLocalVar('petRespawnTime', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
end

return entity
