-----------------------------------
-- Area: Misareaux Coast
--   NM: Upyri
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    -- Nonaggressive during the day. Has Regain, more potent at night.
    local hour = VanadielHour()
    if hour >= 4 and hour < 18 then
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
        mob:setMod(xi.mod.REGAIN, 50)
    else
        mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local hour = VanadielHour()
    local chance = math.random(1, 10)
    if hour < 4 or hour >= 18 and skill:getID() == 1401 then
        local tpCount = mob:getLocalVar("tpCount")

        tpCount = tpCount +1
        mob:setLocalVar("tpCount", tpCount)

        if tpCount > 1 and chance >= 5 then
            mob:setLocalVar("tpCount", 0)
        elseif tpCount > 2 and chance >= 9 then
            mob:setLocalVar("tpCount", 0)
        else
            mob:useMobAbility(skill:getID())
        end
    end
end

entity.onMobDisengage = function(mob)
    -- When it becomes unclaimed, it will immediately regen to 100%.
    mob:setHPP(100)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hr
end

return entity
