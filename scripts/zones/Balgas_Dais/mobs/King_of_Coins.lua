-----------------------------------
-- Area: Balga's Dais
-- NM:
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
end

entity.onMobEngaged = function(mob, target)
    for i = 1, 3 do
        DespawnMob(mob:getID()-i)
    end

    for i = 1, 2 do
        SpawnMob(mob:getID()+i):updateEnmity(target)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 692 then
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
