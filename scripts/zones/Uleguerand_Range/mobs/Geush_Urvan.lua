-----------------------------------
-- Area: Uleguerand Range
--   NM: Father Frost
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetMobSkillAttack(4006) -- replace melee attack with special auto attack
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.REGAIN, 400)
    mob:setMod(xi.mod.MOVE, 12)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("counterTime", os.time() + 120)
end

entity.onMobFight = function(mob, target)
    local counterTime = mob:getLocalVar("counterTime")
    if os.time() > counterTime then
        mob:useMobAbility(603) -- Counterstance with 2hr dust cloud
        mob:setLocalVar("counterTime", os.time() + math.random(120, 240)) -- 2hrs every 2 to 4 min
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar("skill_tp", mob:getTP())
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 603 or skill:getID() == 1460 then
        if skill:getID() == 603 then
            mob:messageText(target, ID.text.GEUSH_COUNTER, false)
        end
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if os.time() < mob:getLocalVar("timeToGrow") then
        DisallowRespawn(ID.mob.FATHER_FROST, true)
        DisallowRespawn(ID.mob.MAIDEN_PH, false)
        GetMobByID(ID.mob.MAIDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.MAIDEN_PH))
    end
end

return entity
