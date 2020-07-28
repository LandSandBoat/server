-----------------------------------
-- Area: The Ashu Talif (Against All Odds)
--  Mob: Gowam
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.SLEEPRES, 150)
    mob:addMod(tpz.mod.SILENCERES, 150)
end

function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.AZURE_LORE))then
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
    else
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:showText(mob, ID.text.GOWAM_DEATH)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
