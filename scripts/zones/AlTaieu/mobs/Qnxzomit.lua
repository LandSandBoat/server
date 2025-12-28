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

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    if mob:getID() < ID.mob.JAILER_OF_LOVE then
        mob:addImmunity(xi.immunity.BIND)
        mob:addImmunity(xi.immunity.BLIND)
        mob:addImmunity(xi.immunity.DARK_SLEEP)
        mob:addImmunity(xi.immunity.LIGHT_SLEEP)
        mob:addImmunity(xi.immunity.PETRIFY)
        mob:addImmunity(xi.immunity.STUN)
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)

    -- only JoJ pops
    if mob:getID() < ID.mob.JAILER_OF_LOVE then
        xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.MIJIN_GAKURE, hpp = 20 }, }, })
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobEngage = function(mob, target)
    -- These are needed to make their NIN main job not behave like a beastmen NIN (no throwing or standing at range to cast)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 0)
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
