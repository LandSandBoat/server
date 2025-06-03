-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
---@type TMobEntity
local entity = {}

local spellTable =
{
    [1161] = { 476, 484 },
    [1162] = { 473, 481 },
    [1163] = { 475, 483 },
    [1164] = { 472, 480 },
    [1165] = { 471, 479 },
    [1166] = { 474, 482 },
    [1167] = { 470, 478 },
    [1168] = { 469, 477 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('twoHourPer', 50)
    mob:setLocalVar('canTwoHour', 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setAnimationSub(0)
    mob:setAggressive(false)
    mob:setLocalVar('roamTime', os.time())
    mob:setLocalVar('form2', math.random(1, 3))
    local skin = math.random(1161, 1168)
    mob:setLocalVar('skin', skin)
    if skin == 1161 then -- Fire
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.ICE_MEVA, 80)
        mob:setMod(xi.mod.PARALYZE_MEVA, 99)
        mob:setMod(xi.mod.BIND_MEVA, 99)
        mob:setMod(xi.mod.FIRE_MEVA, 100)
        mob:setMod(xi.mod.WATER_MEVA, -27)
    elseif skin == 1162 then -- Ice
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.WIND_MEVA, 80)
        mob:setMod(xi.mod.GRAVITY_MEVA, 99)
        mob:setMod(xi.mod.SILENCE_MEVA, 99)
        mob:setMod(xi.mod.ICE_MEVA, 100)
        mob:setMod(xi.mod.PARALYZE_MEVA, 100)
        mob:setMod(xi.mod.BIND_MEVA, 100)
        mob:setMod(xi.mod.FIRE_MEVA, -27)
    elseif skin == 1163 then -- Wind
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.EARTH_MEVA, 80)
        mob:setMod(xi.mod.SLOW_MEVA, 99)
        mob:setMod(xi.mod.WIND_MEVA, 100)
        mob:setMod(xi.mod.GRAVITY_MEVA, 100)
        mob:setMod(xi.mod.SILENCE_MEVA, 100)
        mob:setMod(xi.mod.ICE_MEVA, -27)
    elseif skin == 1164 then -- Earth
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.THUNDER_MEVA, 80)
        mob:setMod(xi.mod.STUN_MEVA, 99)
        mob:setMod(xi.mod.EARTH_MEVA, 100)
        mob:setMod(xi.mod.SLOW_MEVA, 100)
        mob:setMod(xi.mod.WIND_MEVA, -27)
    elseif skin == 1165 then -- Lightning
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.WATER_MEVA, 80)
        mob:setMod(xi.mod.POISON_MEVA, 99)
        mob:setMod(xi.mod.THUNDER_MEVA, 100)
        mob:setMod(xi.mod.STUN_MEVA, 100)
        mob:setMod(xi.mod.EARTH_MEVA, -27)
    elseif skin == 1166 then -- Water
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.FIRE_MEVA, 80)
        mob:setMod(xi.mod.WATER_MEVA, 100)
        mob:setMod(xi.mod.POISON_MEVA, 100)
        mob:setMod(xi.mod.THUNDER_MEVA, -27)
    elseif skin == 1167 then -- Light
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.LIGHT_MEVA, 100)
        mob:setMod(xi.mod.LULLABY_MEVA, 100)
        mob:setMod(xi.mod.DARK_MEVA, -27)
    elseif skin == 1168 then -- Dark
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.DARK_MEVA, 100)
        mob:setMod(xi.mod.SLEEP_MEVA, 100)
        mob:setMod(xi.mod.LIGHT_MEVA, -27)
    end

    mob:setModelId(1167)
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar('changeTime')
    local state = mob:getLocalVar('state')
    local twoHourPer = mob:getLocalVar('twoHourPer')
    if mob:getBattleTime() - changeTime > 30 then
        mob:setLocalVar('state', math.random(0, 3))
        mob:setAnimationSub(state)
        mob:setLocalVar('changeTime', mob:getBattleTime())
    end

    if
        mob:getLocalVar('canTwoHour') == 0 and
        mob:getHPP() < twoHourPer
    then
        if mob:getLocalVar('state') == 1 then
            mob:useMobAbility(694) --invincible
        elseif mob:getLocalVar('state') == 2 then
            mob:useMobAbility(688) -- mighty strikes
        elseif mob:getLocalVar('state') == 0 then
            mob:useMobAbility(691) -- manafont
            local skin = mob:getLocalVar('skin')
            mob:setSpellList(spellTable[skin][1])
            mob:setLocalVar('delay', mob:getBattleTime())
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)
        elseif mob:getLocalVar('state') == 3 then
            mob:useMobAbility(693) -- perfect dodge
        end

        mob:setLocalVar('canTwoHour', 1)
    end

    if
        not mob:hasStatusEffect(xi.effect.MANAFONT) and --Changing spell list back after manafont is over
        mob:getLocalVar('canTwoHour') == 1 and
        mob:getBattleTime() - mob:getLocalVar('delay') > 15 and
        mob:getLocalVar('state2') == 0
    then
        local skin = mob:getLocalVar('skin')
        mob:setSpellList(spellTable[skin][2])
        mob:setLocalVar('state2', 1)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    end
end

entity.onMobDeath  = function(mob, player, optParams)
end

return entity
