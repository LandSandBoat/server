-----------------------------------
-- Area: Grand Palace of HuXzoi
--   NM: Qn'aern
-- Note: The RDM and WHM versions in Palace assist Ix'Aern (MNK)
--       All Qn'aerns can use their respective two-hour abilities multiple times (guessing 2-minute timers)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local mJob = mob:getMainJob()

    if mJob == xi.job.RDM then
        mob:setMod(xi.mod.FASTCAST, 15)
        xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.CHAINSPELL, hpp = math.random(90, 95), cooldown = 120 } } })
    elseif mJob == xi.job.WHM then
        mob:setMod(xi.mod.REGEN, 3)
        xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.BENEDICTION, hpp = math.random(20, 40), cooldown = 120 } } })
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
