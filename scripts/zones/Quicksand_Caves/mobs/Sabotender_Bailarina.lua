-----------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarina
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local lifePercent = mob:getHPP()
    local phase       = mob:getLocalVar('phase')
    local mobTP       = mob:getTP()
    local currentTime = VanadielHour()

    if currentTime >= 6 and currentTime <= 18 then -- autoregen during daytime only
        mob:setMod(xi.mod.REGEN, 30)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end

    if lifePercent < 40 and phase == 0 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
        mob:setLocalVar('phase', 1)
    end

    if lifePercent < 20 and phase == 1 then
        mob:setLocalVar('phase', 2)
    end

    if phase == 1 and mobTP >= 1000 then
        mob:setLocalVar('1000', 2)
    end

    if phase == 2 and mobTP >= 1000 then
        mob:setLocalVar('1000', 3)
    end

    if mob:getLocalVar('1000') == 3 then
        local move = math.random(1, 2)

        if move == 1 and (currentTime >= 6 and currentTime <= 18) then -- photosynthesis during daytime only
            mob:useMobAbility(304)
        else
            mob:useMobAbility(322)
        end

        mob:setLocalVar('1000', 2)
    elseif mob:getLocalVar('1000') == 2 then
        local move = math.random(1, 2)

        if move == 1 and (currentTime >= 6 and currentTime <= 18) then
            mob:useMobAbility(304)
        else
            mob:useMobAbility(322)
        end

        mob:setLocalVar('1000', 1)
    elseif mob:getLocalVar('1000') == 1 then
        local move = math.random(1, 2)

        if move == 1 and (currentTime >= 6 and currentTime <= 18) then
            mob:useMobAbility(304)
        else
            mob:useMobAbility(322)
        end

        mob:setLocalVar('1000', 0)
        mob:setTP(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 438)
end

return entity
