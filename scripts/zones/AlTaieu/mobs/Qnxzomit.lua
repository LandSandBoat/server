-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JoL and JoJ
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobEngage = function(mob, target)
    -- These are needed to make their NIN main job not behave like a beastmen NIN (no throwing or standing at range to cast)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 0)

    -- only JoJ pops
    if mob:getID() < ID.mob.JAILER_OF_LOVE then
        mob:timer(30000, function(mobArg)
            if mobArg:isAlive() then
                mobArg:useMobAbility(xi.jsa.MIJIN_GAKURE)
                mobArg:timer(2000, function(mobArg2)
                    mobArg2:setHP(0)
                end)
            end
        end)

        mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60) -- TODO: is this real (aura stealable) or is this supposed to be movement speed?
    end
end

entity.onMobDespawn = function(mob)
    -- only JoL pops
    if mob:getID() > ID.mob.JAILER_OF_LOVE then
        local jailerOfLove = GetMobByID(ID.mob.JAILER_OF_LOVE)

        if jailerOfLove then
            local xzomitsKilled = jailerOfLove:getLocalVar('JoL_Qn_xzomit_Killed')

            jailerOfLove:setLocalVar('JoL_Qn_xzomit_Killed', xzomitsKilled + 1)
        end
    end
end

return entity
