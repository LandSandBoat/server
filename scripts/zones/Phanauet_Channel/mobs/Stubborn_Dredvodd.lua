-----------------------------------
-- Area: Phanauet Channel (1)
--  NM: Stubborn Dredvodd
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimtationSub(1)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
end


entity.onMobFight = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(43200, 54000)) -- 12 - 15 hours
end

return entity