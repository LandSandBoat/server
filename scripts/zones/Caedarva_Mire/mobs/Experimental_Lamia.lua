-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Experimental Lamia
-- !pos -773.369 -11.824 322.298 79
-- Mobid: 17101205
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
mixins  = {require("scripts/mixins/job_special"),
           require("scripts/mixins/rage")}
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 30)
    mob:addMod(xi.mod.INT, 70)
    mob:addMod(xi.mod.MND, 30)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 30)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 200)
    mob:setMod(xi.mod.DARK_MEVA, 200)
    mob:setMod(xi.mod.LIGHT_MEVA, 200)
    mob:setMod(xi.mod.FIRE_MEVA, 200)
    mob:setMod(xi.mod.WATER_MEVA, 300)
    mob:setMod(xi.mod.ICE_MEVA, 150)
    mob:setMod(xi.mod.WIND_MEVA, 200)
    mob:setMod(xi.mod.EARTH_SDT, 200)
    mob:setMod(xi.mod.DARK_SDT, 200)
    mob:setMod(xi.mod.LIGHT_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 300)
    mob:setMod(xi.mod.ICE_SDT, 150)
    mob:setMod(xi.mod.WIND_SDT, 200)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 50)
    mob:addMod(xi.mod.MATT, 20)
    mob:addMod(xi.mod.MACC, 25)
    mob:addMod(xi.mod.MOVE, 12)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setAnimationSub(0)
end

entity.onAdditionalEffect = function(mob, target, damage)
 return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER, {chance = 25, power = math.random(15, 50)})
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.EES_LAMIA, hpp = 100},
            {id = xi.jsa.EES_LAMIA, hpp = 75},
            {id = xi.jsa.EES_LAMIA, hpp = 50},
            {id = xi.jsa.EES_LAMIA, hpp = 25},
        },
    })
end

local function spawnMinions(mob, target)
    mob:setLocalVar("spawnedMinions", 1)

    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        minion:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
        minion:spawn()
        minion:updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 75 and mob:getLocalVar("spawnedMinions") == 0 then
        spawnMinions(mob, target)
    end

    -- make sure minions have a target
    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        if minion:getCurrentAction() == xi.act.ROAMING then
            minion:updateEnmity(target)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if mob:getLocalVar("spawnedMinions") == 0 then
        spawnMinions(mob, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
