-----------------------------------
-- Area: Navukgo Execution Chamber
--   NM: Watch Wamoura
-----------------------------------
---@type TMobEntity
local entity = {}

local function curl(mob)
    mob:setBaseSpeed(20)
    mob:setMod(xi.mod.DMG, -9500)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 100, 0, 0)
    mob:setAnimationSub(5)
    mob:setLocalVar('stretchTime', os.time() + math.random(65, 80))
end

local function stretch(mob)
    mob:setBaseSpeed(100)
    mob:delMod(xi.mod.DMG, -9500)
    mob:delStatusEffect(xi.effect.BLAZE_SPIKES)
    mob:setAnimationSub(4)
    mob:setLocalVar('curlThreshold', math.max(0, mob:getHPP() - 20))
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMod(xi.mod.REGAIN, 150)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    curl(mob)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('stretchTime', os.time() + math.random(65, 80))
    mob:setLocalVar('curlThreshold', math.max(0, mob:getHPP() - 20))
end

entity.onMobFight = function(mob, target)
    local animation = mob:getAnimationSub()
    if animation == 4 and mob:getHPP() < mob:getLocalVar('curlThreshold') then
        curl(mob)
    elseif animation == 5 and os.time() >= mob:getLocalVar('stretchTime') then
        stretch(mob)
    end

    if animation == 4 and os.time() >= mob:getLocalVar('resetEnmity') then
        -- While stretched out the mob is constantly switching its target
        local enmitylist = mob:getEnmityList()

        for _, enmity in ipairs(enmitylist) do
            if enmity.active then
                mob:addEnmity(enmity.entity, 1, 0)
            end
        end

        local currentTarget = mob:getTarget()
        if currentTarget then
            mob:resetEnmity(currentTarget)
            mob:setLocalVar('resetEnmity', os.time() + 3)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
