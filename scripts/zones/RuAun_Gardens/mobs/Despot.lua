-----------------------------------
-- Area: RuAun Gardens
--   NM: Despot
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 60)
    mob:setMod(xi.mod.MOVE, 12)
    local ph = GetMobByID(mob:getLocalVar("ph"))
    if ph then
        local pos = ph:getPos()
        mob:setPos(pos.x, pos.y, pos.z, pos.r)
        local killerId = ph:getLocalVar("killer")
        if killerId ~= 0 then
            local killer = GetPlayerByID(killerId)
            if not killer:isEngaged() and killer:checkDistance(mob) <= 50 then
                mob:updateClaim(killer)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    local panzerfaustCounter = mob:getLocalVar("panzerfaustCounter")
    local panzerfaustMax = mob:getLocalVar("panzerfaustMax")

    if panzerfaustCounter == panzerfaustMax and panzerfaustMax > 0 then
        mob:setLocalVar("panzerfaustCounter", 0)
        mob:setLocalVar("panzerfaustMax", 0)
    end

    if panzerfaustMax > 0 and mob:canUseAbilities() and mob:checkDistance(target) < 6 then
        if panzerfaustCounter > panzerfaustMax then
            mob:setLocalVar("panzerfaustCounter", 0)
            mob:setLocalVar("panzerfaustMax", 0)
        else
            mob:setLocalVar("panzerfaustCounter", panzerfaustCounter + 1)
            mob:useMobAbility(536)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local panzerfaustCounter = mob:getLocalVar("panzerfaustCounter")
    local panzerfaustMax = mob:getLocalVar("panzerfaustMax")

    if panzerfaustCounter == 0 and panzerfaustMax == 0 then
        panzerfaustMax = math.random(2, 5)
        mob:setLocalVar("panzerfaustMax", panzerfaustMax)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:removeListener("PH_VAR")
    mob:resetLocalVars()
end

return entity
