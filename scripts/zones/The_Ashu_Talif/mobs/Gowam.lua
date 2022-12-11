-----------------------------------
-- Area: The Ashu Talif (Against All Odds)
--  Mob: Gowam
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEP_MEVA, 150)
    mob:addMod(xi.mod.SILENCE_MEVA, 150)
end

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.AZURE_LORE) then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)
    else
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.GOWAM_DEATH)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
