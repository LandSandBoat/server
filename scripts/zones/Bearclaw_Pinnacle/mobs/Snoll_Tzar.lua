-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Snoll Tzar
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMobMod(xi.mobMod.SIGHT_RANGE, 30)
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'SNOLL_EXPLOSION', function(snoll, skillID)
        if skillID == xi.mobSkill.HYPOTHERMAL_COMBUSTION_2 then
            snoll:getBattlefield():lose()
        end
    end)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('changeTime', GetSystemTime() + 20)
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()
    local currentSize = mob:getAnimationSub()
    local saltTime    = mob:getLocalVar('saltTime')

    -- Handle Shumeyo Salt effects
    if saltTime > currentTime then
        -- Show steam message every 7-10 seconds
        local nextSteam = mob:getLocalVar('nextSteam')
        if currentTime >= nextSteam then
            mob:messageText(mob, ID.text.LARGE_STEAM)
            mob:setLocalVar('nextSteam', currentTime + math.random(7, 10))
        end

    -- Salt just wore off - show message and reset
    elseif saltTime > 0 and saltTime <= currentTime then
        mob:messageText(mob, ID.text.SHOOK_SALT)
        mob:setLocalVar('saltTime', 0)
    end

    -- Handle size changes
    local changeTime = mob:getLocalVar('changeTime')
    if currentTime >= changeTime then
        switch (currentSize): caseof
        {
            [4] = function()
                mob:setAnimationSub(5)
                mob:setDamage(140)
                mob:setLocalVar('changeTime', changeTime + math.random(20, 25))
            end,

            [5] = function()
                mob:setAnimationSub(6)
                mob:setDamage(150)
                mob:setLocalVar('changeTime', changeTime + math.random(20, 25))
            end,

            [6] = function()
                mob:setAnimationSub(7)
                mob:setDamage(160)
                mob:setLocalVar('changeTime', changeTime + 90)
            end,

            [7] = function()
                mob:useMobAbility(xi.mobSkill.HYPOTHERMAL_COMBUSTION_2)
            end,
        }
    end
end

entity.onMobMobskillChoose = function(mob, target)
    if
        mob:getAnimationSub() == 7 and
        math.random(1, 100) <= 75
    then
        return xi.mobSkill.HYPOTHERMAL_COMBUSTION_2
    end

    local tpList =
    {
        xi.mobSkill.ARCTIC_IMPACT,
        xi.mobSkill.COLD_WAVE_2,
        xi.mobSkill.HIEMAL_STORM,
    }

    return tpList[math.random(1, #tpList)]
end

entity.onMobDeath = function(mob, player, optParams)
    mob:removeListener('SNOLL_EXPLOSION')
end

return entity
