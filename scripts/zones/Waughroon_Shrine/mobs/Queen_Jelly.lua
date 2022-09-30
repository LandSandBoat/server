-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Queen Jelly
-- BCNM: Royal Jelly
-----------------------------------
<<<<<<< Updated upstream
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 200)
    mob:addMod(xi.mod.ACC, 100)
    mob:addMod(xi.mod.FASTCAST,30);
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMod(xi.mod.SPELLINTERRUPT, 25)
end

entity.onMobSpawn = function(mob)
    mob:setSpeed(60)
end

entity.onMobDeath = function(mob, player, isKiller)
=======
local entity = {}

entity.onMobEngaged = function(mob, target)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDeath = function(mob, player, isKiller)
  DespawnMob(17367174)
  DespawnMob(17367175)
  DespawnMob(17367176)
  DespawnMob(17367177)
  DespawnMob(17367178)
  DespawnMob(17367179)
  DespawnMob(17367180)
  DespawnMob(17367181)
>>>>>>> Stashed changes
end

return entity
