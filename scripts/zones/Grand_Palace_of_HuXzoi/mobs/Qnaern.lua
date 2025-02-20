-----------------------------------
-- Area: Grand Palace of HuXzoi
--   NM: Qn'aern
-- Note: The RDM and WHM versions in Palace assist Ix'Aern (MNK)
--       All Qn'aerns can use their respective two-hour abilities multiple times
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)

    local mJob = mob:getMainJob()

    if mJob == xi.job.RDM then
        mob:setMod(xi.mod.FASTCAST, 15)
        -- captures show chainspell cooldowns of one min and four mins (select a random value between)
        xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.CHAINSPELL, hpp = math.random(90, 95), cooldown = math.random(60, 240) } } })
    elseif mJob == xi.job.WHM then
        mob:setMod(xi.mod.REGEN, 3)
        xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.BENEDICTION, hpp = math.random(20, 40), cooldown = 120 } } })
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
