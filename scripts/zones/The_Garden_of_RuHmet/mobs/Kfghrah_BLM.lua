-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Kf'ghrah BLM
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    -- Set core Skin and mob elemental bonus
    mob:setAnimationSub(0)
    mob:setLocalVar('roamTime', GetSystemTime())
    mob:setModelId(1169)

    -- TODO: confirm this is legit and move to mob_reistances table if so.
    -- It isn't.
    mob:addMod(xi.mod.LIGHT_MEVA, -100)
    mob:addMod(xi.mod.DARK_MEVA, 100)
end

entity.onMobRoam = function(mob)
    local currentTime = GetSystemTime()
    if currentTime - mob:getLocalVar('changeTime') <= 90 then
        return
    end

    if mob:getAnimationSub() == 0 then
        mob:setAnimationSub(math.randomInt(2, 3)) -- Switch from form 0 to form 2 or 3
    else
        mob:setAnimationSub(0)                    -- Switch back to form 0
    end

    mob:setLocalVar('changeTime', currentTime)
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()
    if currentTime - mob:getLocalVar('changeTime') <= 90 then
        return
    end

    if mob:getAnimationSub() == 0 then
        mob:setAnimationSub(math.randomInt(2, 3)) -- Switch from form 0 to form 2 or 3
    else
        mob:setAnimationSub(0)                    -- Switch back to form 0
    end

    mob:setLocalVar('changeTime', currentTime)
end

return entity
