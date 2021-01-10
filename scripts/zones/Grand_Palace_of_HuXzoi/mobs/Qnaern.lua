-----------------------------------
-- Area: Grand Palace of HuXzoi
--   NM: Qn'aern
-- Note: The RDM and WHM versions in Palace assist Ix'Aern (MNK)
--       All Qn'aerns can use their respective two-hour abilities multiple times (guessing 2-minute timers)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    local mJob = mob:getMainJob()

    if mJob == tpz.job.RDM then
        mob:setMod(tpz.mod.FASTCAST, 15)
        tpz.mix.jobSpecial.config(mob, {specials = {{id = tpz.jsa.CHAINSPELL, hpp = math.random(90, 95), cooldown = 120}}})
    elseif mJob == tpz.job.WHM then
        mob:setMod(tpz.mod.REGEN, 3)
        tpz.mix.jobSpecial.config(mob, {specials = {{id = tpz.jsa.BENEDICTION, hpp = math.random(20, 40), cooldown = 120}}})
    end
end

function onMobDeath(mob, player, isKiller)
end

return entity
