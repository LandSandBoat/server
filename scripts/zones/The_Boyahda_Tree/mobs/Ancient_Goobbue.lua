-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ancient Goobbue
-----------------------------------
mixins = { require('scripts/mixins/draw_in'), }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.CRITHITRATE, 25)
    mob:setLocalVar('[2hour]HPP', math.randomInt(98, 99))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getHPP() >= mob:getLocalVar('[2hour]HPP') then
        return
    end

    local currentTime = GetSystemTime()
    local twoHourTime = mob:getLocalVar('[2hour]Time')
    if twoHourTime == 0 then
        mob:setLocalVar('[2hour]Time', currentTime)
        return
    end

    if currentTime < twoHourTime then
        return
    end

    -- Handle 2 Hour
    mob:useMobAbility(xi.mobSkill.HUNDRED_FISTS_1)
    mob:setLocalVar('[2hour]Time', currentTime + 65)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
