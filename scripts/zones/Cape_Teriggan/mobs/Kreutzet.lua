-----------------------------------
-- Area: Cape Teriggan
--   NM: Kreutzet
-----------------------------------
---@type TMobEntity
local entity = {}

-- Kreutzet Stormwind Chain fTP (3.00 -> 3.25 -> 3.60)
local stormwindFTP =
{
    [1] = 3.00,
    [2] = 3.25,
    [3] = 3.60,
}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(32400, 43200)) -- 9 to 12 hours
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn

    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('WEATHER_CHANGE', 'KREUTZET_WEATHER_CHANGE', function(mobArg, weather, element)
        if not mobArg:isSpawned() then
            return
        end

        if mobArg:isEngaged() then
            return
        end

        if element ~= xi.element.WIND then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('stormwindCounter', 0)
    mob:setfTPModifierOverride(xi.mobSkill.STORMWIND, stormwindFTP[1], stormwindFTP[1], stormwindFTP[1])
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local stormwindCounter = mob:getLocalVar('stormwindCounter')
    if stormwindCounter == 3 then
        mob:setLocalVar('stormwindCounter', 0)
        mob:setfTPModifierOverride(xi.mobSkill.STORMWIND, stormwindFTP[1], stormwindFTP[1], stormwindFTP[1])
    elseif
        stormwindCounter >= 1 and
        mob:checkDistance(target) <= 15
    then
        stormwindCounter = stormwindCounter + 1
        mob:setLocalVar('stormwindCounter', stormwindCounter)

        local ftp = stormwindFTP[stormwindCounter]
        mob:setfTPModifierOverride(xi.mobSkill.STORMWIND, ftp, ftp, ftp)
        mob:useMobAbility(xi.mobSkill.STORMWIND)
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local stormwindCounter = mob:getLocalVar('stormwindCounter')
    if
        skill:getID() == xi.mobSkill.STORMWIND and
        stormwindCounter == 0
    then
        mob:setLocalVar('stormwindCounter', 1)
    end
end

entity.onMobDisengage = function(mob)
    if xi.data.element.getWeatherElement(mob:getWeather()) ~= xi.element.WIND then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    -- Set Kruetzet's spawnpoint and respawn time (9-12 hours)
    mob:setRespawnTime(math.randomInt(32400, 43200))
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

return entity
