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

    -- Todo: confirm this is legit and move to mob_reistances table if so
    mob:addMod(xi.mod.LIGHT_MEVA, -100)
    mob:addMod(xi.mod.DARK_MEVA, 100)
end

entity.onMobRoam = function(mob)
    local changeTime = mob:getLocalVar('changeTime')
    local roamForm = 0
    if GetSystemTime() - changeTime > 90 then
        local currentForm = mob:getAnimationSub()
        if currentForm == 0 then
            roamForm = math.random(2, 3) -- Switch from form 0 to form 2 or 3
        else
            roamForm = 0 -- Switch back to form 0
        end

        mob:setAnimationSub(roamForm)
        mob:setLocalVar('changeTime', GetSystemTime())
    end
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar('changeTime')
    local roamForm = 0
    if GetSystemTime() - changeTime > 90 then
        local currentForm = mob:getAnimationSub()
        if currentForm == 0 then
            roamForm = math.random(2, 3) -- Switch from form 0 to form 2 or 3
        else
            roamForm = 0 -- Switch back to form 0
        end

        mob:setAnimationSub(roamForm)
        mob:setLocalVar('changeTime', GetSystemTime())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
