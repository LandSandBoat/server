-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Goblin Wolfman
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addMod(xi.mod.ACC, 70) -- Very accurate
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.jsa.BLOOD_WEAPON then
        mob:addMod(xi.mod.DELAY, 1500)
        mob:addMod(xi.mod.ATTP, 160)
        mob:setLocalVar("removeMods", 1)
    end
end

entity.onMobFight = function(mob, target)
    if not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and mob:getLocalVar("removeMods") == 1 then
        mob:delMod(xi.mod.DELAY, 1500)
        mob:delMod(xi.mod.ATTP, 160)
        mob:setLocalVar("removeMods", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 245)
end

return entity
