-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

local spellTable =
{
    [1161] = { 476, 484 },
    [1162] = { 471, 479 },
    [1163] = { 472, 480 },
    [1164] = { 473, 481 },
    [1165] = { 474, 482 },
    [1166] = { 475, 483 },
    [1167] = { 470, 478 },
    [1168] = { 469, 477 },
}

local dayToSkin =
{
    [xi.day.FIRESDAY]     = { 1161 },
    [xi.day.EARTHSDAY]    = { 1164 },
    [xi.day.WATERSDAY]    = { 1166 },
    [xi.day.WINDSDAY]     = { 1163 },
    [xi.day.ICEDAY]       = { 1162 },
    [xi.day.LIGHTNINGDAY] = { 1165 },
    [xi.day.LIGHTSDAY]    = { 1167 },
    [xi.day.DARKSDAY]     = { 1168 },
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.REGEN, 20)
    mob:setLocalVar("twoHourPer", 50)
    mob:setLocalVar("canTwoHour", 0)
    mob:setLocalVar("roamTime", os.time())
    mob:setAnimationSub(0)
    mob:setAggressive(false)

    local skin = dayToSkin[VanadielDayOfTheWeek()][1]
    mob:setLocalVar("skin", skin)
    if skin == 1161 then -- Fire
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.ICE_MEVA, 80)
        mob:setMod(xi.mod.PARALYZERES, 99)
        mob:setMod(xi.mod.BINDRES, 99)
        mob:setMod(xi.mod.FIRE_MEVA, 100)
        mob:setMod(xi.mod.WATER_MEVA, -27)
    elseif skin == 1162 then -- Ice
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.WIND_MEVA, 80)
        mob:setMod(xi.mod.GRAVITYRES, 99)
        mob:setMod(xi.mod.SILENCERES, 99)
        mob:setMod(xi.mod.ICE_MEVA, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.FIRE_MEVA, -27)
    elseif skin == 1163 then -- Wind
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.EARTH_MEVA, 80)
        mob:setMod(xi.mod.SLOWRES, 99)
        mob:setMod(xi.mod.WIND_MEVA, 100)
        mob:setMod(xi.mod.GRAVITYRES, 100)
        mob:setMod(xi.mod.SILENCERES, 100)
        mob:setMod(xi.mod.ICE_MEVA, -27)
    elseif skin == 1164 then -- Earth
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.THUNDER_MEVA, 80)
        mob:setMod(xi.mod.STUNRES, 99)
        mob:setMod(xi.mod.EARTH_MEVA, 100)
        mob:setMod(xi.mod.SLOWRES, 100)
        mob:setMod(xi.mod.WIND_MEVA, -27)
    elseif skin == 1165 then -- Lightning
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.WATER_MEVA, 80)
        mob:setMod(xi.mod.POISONRES, 99)
        mob:setMod(xi.mod.THUNDER_MEVA, 100)
        mob:setMod(xi.mod.STUNRES, 100)
        mob:setMod(xi.mod.EARTH_MEVA, -27)
    elseif skin == 1166 then -- Water
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.FIRE_MEVA, 80)
        mob:setMod(xi.mod.WATER_MEVA, 100)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.THUNDER_MEVA, -27)
    elseif skin == 1167 then -- Light
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.LIGHT_MEVA, 100)
        mob:setMod(xi.mod.LULLABYRES, 100)
        mob:setMod(xi.mod.DARK_MEVA, -27)
    elseif skin == 1168 then -- Dark
        mob:setSpellList(spellTable[skin][2])
        mob:setMod(xi.mod.DARK_MEVA, 100)
        mob:setMod(xi.mod.SLEEPRES, 100)
        mob:setMod(xi.mod.LIGHT_MEVA, -27)
    end

    mob:setModelId(1167)
end

entity.onMobFight = function(mob, target)
    local state = mob:getLocalVar("state")
    local twoHourPer = mob:getLocalVar("twoHourPer")
    local change = mob:getLocalVar("change")
    if change == 1 and mob:canUseAbilities() then
        state = math.random(0, 3)
        while state == mob:getAnimationSub() do
            state = math.random(0, 3)
        end

        local hpp = mob:getHPP()
        if state == 0 then -- Ball
            mob:changeJob(xi.job.BLM)
            -- need to set hpp back to level before job change since the change heals to full
            mob:setHP(math.floor(mob:getMaxHP() * (hpp / 100.0)))
            mob:setMagicCastingEnabled(true)
            mob:setMod(xi.mod.DMG, 0)
            mob:setMod(xi.mod.DMGPHYS, 0)
            mob:setDamage(79)
        elseif state == 1 then -- Human
            mob:changeJob(xi.job.PLD)
            mob:setHP(math.floor(mob:getMaxHP() * (hpp / 100.0)))
            mob:setMagicCastingEnabled(true)
            mob:setMod(xi.mod.DMG, -5000)
            mob:setMod(xi.mod.DMGPHYS, 0)
            mob:setDamage(79)
        elseif state == 2 then -- Spider
            mob:changeJob(xi.job.WAR)
            mob:setHP(math.floor(mob:getMaxHP() * (hpp / 100.0)))
            mob:setMagicCastingEnabled(false)
            mob:setMod(xi.mod.DMG, 0)
            mob:setMod(xi.mod.DMGPHYS, 3000)
            mob:setDamage(140)
        elseif state == 3 then -- Bird
            mob:changeJob(xi.job.THF)
            mob:setHP(math.floor(mob:getMaxHP() * (hpp / 100.0)))
            mob:setMagicCastingEnabled(false)
            mob:setMod(xi.mod.DMG, 0)
            mob:setMod(xi.mod.DMGPHYS, 0)
            mob:setDamage(79)
        end

        mob:setLocalVar("state", state)
        mob:setAnimationSub(state)
        mob:setLocalVar("change", 0)
    end

    if
        mob:getLocalVar("canTwoHour") == 0 and
        mob:getHPP() < twoHourPer
    then
        if mob:getLocalVar("state") == 1 then
            mob:useMobAbility(694) --invincible
        elseif mob:getLocalVar("state") == 2 then
            mob:useMobAbility(688) -- mighty strikes
        elseif mob:getLocalVar("state") == 0 then
            mob:useMobAbility(691) -- manafont
            local skin = mob:getLocalVar("skin")
            mob:setSpellList(spellTable[skin][1])
            mob:setLocalVar("delay", mob:getBattleTime())
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)
        elseif mob:getLocalVar("state") == 3 then
            mob:useMobAbility(693) -- perfect dodge
        end

        mob:setLocalVar("canTwoHour", 1)
    end

    if
        not mob:hasStatusEffect(xi.effect.MANAFONT) and --Changing spell list back after manafont is over
        mob:getLocalVar("canTwoHour") == 1 and
        mob:getBattleTime() - mob:getLocalVar("delay") > 15 and
        mob:getLocalVar("state2") == 0
    then
        local skin = mob:getLocalVar("skin")
        mob:setSpellList(spellTable[skin][2])
        mob:setLocalVar("state2", 1)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local form = mob:getAnimationSub()
    if form == 0 and skill:getID() == 1443 then -- In ball form and used hexidiscs
        mob:setLocalVar("change", 1)
    elseif form == 1 and skill:getID() == 1444 then -- In human form and used vorpal blade
        mob:setLocalVar("change", 1)
    elseif form == 2 and skill:getID() == 1446 then -- In spider form and used sickle slash
        mob:setLocalVar("change", 1)
    elseif form == 3 and skill:getID() == 1445 then -- In bird form and used damnation dive
        mob:setLocalVar("change", 1)
    end
end

entity.onMobDeath  = function(mob, player, optParams)
    local missionVar = string.format("Mission[%d][%d]Status", xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
    if player:getCharVar(missionVar) == 1 then
        player:setCharVar(missionVar, 2)
    end
end

return entity
