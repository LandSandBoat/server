-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Toadpillow
-- BCNM: Toadal Recall
-----------------------------------
--- AnimationSub3 - No Mushrooms
--- AnimationSub2 - One Mushrooms
--- AnimationSub1 - Two Mushrooms
--- AnimationSub0 - Three Mushrooms
-----------------------------------
---@type TMobEntity
local entity = {}

local function tryRegrowMushrooms(mob)
    local nextTime = mob:getLocalVar('regrowMushrooms')
    local currentTime = GetSystemTime()

    -- Im out of mushrooms! Set a time to regrow them
    if nextTime == 0 then
        mob:setLocalVar('regrowMushrooms', GetSystemTime() + math.random(60, 80))
        return
    end

    -- It's time! Regrow the mushrooms
    if currentTime >= nextTime then
        mob:setAnimationSub(0)
        mob:injectActionPacket(mob:getID(), 11, 435, 0, 0x18, 0, 0, 0)
        mob:setLocalVar('regrowMushrooms', 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
end

entity.onMobEngage = function(mob)
    -- We set these up here to prevent all funguars from immediately using their skills on pull
    local currentTime   = GetSystemTime()
    mob:setLocalVar('tpWait', math.random(5, 15))
    mob:setLocalVar('tpLast', currentTime)
end

entity.onMobFight = function(mob, target)
    local currentTime   = GetSystemTime()
    local animationSub  = mob:getAnimationSub()
    local lastSkillTime = mob:getLocalVar('tpLast')
    local skillWait     = mob:getLocalVar('tpWait')

    -- Regrowth logic.
    if animationSub == 3 then
        tryRegrowMushrooms(mob)
        return
    end

    -- Busy check.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- If we don't have any mushrooms, or it's not been enough time since our last TP move, do nothing
    if currentTime - lastSkillTime < skillWait then
        return
    end

    local skillTable =
    {
        [0] = xi.mobSkill.QUEASYSHROOM_1,
        [1] = xi.mobSkill.NUMBSHROOM_1,
        [2] = xi.mobSkill.SHAKESHROOM_1,
    }

    -- Use the skill and set up our next wait time
    mob:useMobAbility(skillTable[animationSub])
    mob:setLocalVar('tpLast', currentTime)
    mob:setLocalVar('tpWait', math.random(5, 15))
end

return entity
