-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ancient Goobbue
-----------------------------------
mixins = { require('scripts/mixins/draw_in'), }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -134.491, y = 7.781, z = -212.219 },
    { x = -129.664, y = 8.769, z = -200.913 },
    { x = -116.964, y = 8.804, z = -191.322 },
    { x = -106.853, y = 8.376, z = -204.923 },
    { x = -103.469, y = 8.415, z = -219.308 },
    { x = -102.345, y = 7.962, z = -231.227 },
    { x = -113.924, y = 8.615, z = -244.987 },
    { x = -133.790, y = 8.274, z = -246.496 },
    { x = -123.168, y = 8.797, z = -238.819 },
    { x = -116.133, y = 8.620, z = -224.748 },
    { x = -118.875, y = 8.688, z = -210.279 },
}

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
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
