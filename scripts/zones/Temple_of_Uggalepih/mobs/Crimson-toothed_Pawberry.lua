-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Crimson-toothed Pawberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    xi.pet.setMobPet(mob, 1, 'Tonberrys_Elemental')

    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:useMobAbility(xi.mobSkill.ASTRAL_FLOW_1)
    mob:setLocalVar('[2hour]HPP', math.randomInt(40, 50))
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
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
    mob:useMobAbility(xi.mobSkill.ASTRAL_FLOW_1)
    mob:setLocalVar('[2hour]Time', currentTime + 60)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 392)
end

return entity
