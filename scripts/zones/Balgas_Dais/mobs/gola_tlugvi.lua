-----------------------------------
-- Area: Balga's Dais
--  Mob: Gola Tlugvi
-- KSNM: Seasons Greetings
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.jsa.BLOOD_WEAPON then
        GetMobByID(mob:getID()-3):updateEnmity(mob:getTarget())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
