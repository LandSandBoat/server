-----------------------------------
-- CatsEyeXI SKY 2.0
-- Area: Escha RuAun
-- NM: Seiryu
-- Mobid: 17961565
-- !pos 548.3620 -70.0200 -87.0704 289
-- !addkeyitem 2950
-- weak to ice
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = {
require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/mobs")
require("scripts/globals/magic")
-----------------------------------
local entity = {}
local despawnMobTable =
{
    17961106,
    17961107,
    17961108,
    17961109,
    17961110,
    17961111,
    17961112,
    17961113
}

local mobAbilities =
{
    673, -- Dark Nova
    814, -- Deadly Drive
    816, -- Fang Rush
    817, -- Dread Shriek
    818, -- Tail Crush
    821, -- Radiant Breath
    986  -- Vortex
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 15)
    mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
    mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addStatusEffect(xi.effect.REGAIN, 15, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 10, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 25, 3, 0)
    mob:setMod(xi.mod.MOVE, 25)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 100)
    mob:setMod(xi.mod.DARK_MEVA, 100)
    mob:setMod(xi.mod.LIGHT_MEVA, 100)
    mob:setMod(xi.mod.FIRE_MEVA, 200)
    mob:setMod(xi.mod.WATER_MEVA, 100)
    mob:setMod(xi.mod.THUNDER_MEVA, 100)
    mob:setMod(xi.mod.WIND_MEVA, 200)
    mob:setMod(xi.mod.EARTH_SDT, 100)
    mob:setMod(xi.mod.DARK_SDT, 100)
    mob:setMod(xi.mod.LIGHT_SDT, 100)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 100)
    mob:setMod(xi.mod.THUNDER_SDT, 100)
    mob:setMod(xi.mod.WIND_SDT, 200)
    mob:addMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
    mob:addMod(xi.mod.UFASTCAST, 150)
    mob:setMod(xi.mod.COUNTER, 25)
    mob:setSpellList(231)
	mob:setDropID(3993)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if math.random() > .5 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, {chance = 50})
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE, {chance = 25})
    end
end
-- 30 minute rage timer
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ICE_MEVA, 200)
    mob:setMod(xi.mod.ICE_SDT, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 25, 0, 0)
    mob:setLocalVar("[rage]timer", 1800)
	for _, despawnMob in ipairs(despawnMobTable) do
	    DespawnMob(despawnMob)
    end
end

entity.onMobFight = function(mob, target)
    local lifePercent = mob:getHPP()
    local phase = mob:getLocalVar("phase")
    local phaseSKILL = mob:getLocalVar("phaseSKILL")
    local windWALL = mob:getLocalVar("windWALL")
    local alliance = target:getAlliance()

-- Every weaponskill is followed up with Wind Wall.	
    mob:addListener("WEAPONSKILL_USE", "WIND_WALL_BONUS", function(mobArg, target, wsid, tp, action)
        for _, mobSkill in ipairs(mobAbilities) do
            if wsid == mobSkill then
                mob:setLocalVar("windWALL", 1)
            end
        end
    end) 
-- HP phases defined here
    if lifePercent <= 100 and lifePercent >= 81 then
        mob:setLocalVar("phase", 1)
    end

    if lifePercent <= 78 and lifePercent >= 61 then
        mob:setLocalVar("phase", 2)
    end

    if lifePercent <= 58 and lifePercent >= 41 then
        mob:setLocalVar("phase", 1)
    end

    if lifePercent <= 38 and lifePercent >= 21 then
        mob:setLocalVar("phase", 2)
    end

    if lifePercent <= 18 and lifePercent >= 1 then
        mob:setLocalVar("phase", 1)
    end
-- Phase 1 takes magic damage and absorbs melee damage.
    if phase == 1 then
        mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
        mob:delStatusEffect(xi.effect.MIGHTY_STRIKES)
        mob:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 1, 2, 0, 0)
-- Phase 2 takes melee dmg and is immune to magic damage.
    elseif phase == 2 then
        mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
        mob:delStatusEffect(xi.effect.HUNDRED_FISTS)
        mob:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 1, 1, 0, 0)
    end
-- Use a special abilty on phase changes and reset Enmity
    if phaseSKILL == 0 and phase == 1 then
        mob:weaknessTrigger(1)
        mob:useMobAbility(673) --Dark Nova
        mob:resetEnmity(target)
        mob:setLocalVar("phaseSKILL", 1)
    end

    if phaseSKILL == 1 and phase == 2 then
        mob:weaknessTrigger(2)
        mob:useMobAbility(986) -- Vortex
        mob:resetEnmity(target)
        mob:setLocalVar("phaseSKILL", 0)
    end
-- Reset wind wall bonus listener
    if windWALL == 1 then
        mob:useMobAbility(815) -- Wind Wall
        mob:setLocalVar("windWALL", 0)
	end
-- Benediction on player death, used once under 26%HPP.
    mob:addListener("ATTACKED", "DEATH", function(mobArg, player, action)
        for _, member in pairs(alliance) do
            if member:getZoneID() == player:getZoneID() and member:isDead() and mobArg:getLocalVar("bene") == 0
            and lifePercent <= 26 and lifePercent >= 1 then
                mobArg:setLocalVar("bene", 1)
                mobArg:useMobAbility(689)
            end
        end
    end)
-- Weakness trigger, hit with Zephyr
    mob:addListener("EFFECT_GAIN", "ZEPHYR", function(mob, effect)
        if effect:getEffectType() == xi.effect.AMNESIA then
            mob:weaknessTrigger(3)
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
            mob:setMod(xi.mod.ICE_MEVA, 0)
            mob:setMod(xi.mod.ICE_SDT, 0)
            mob:setMobMod(xi.mobMod.ADD_EFFECT, 0)
        end
    end)
end
-- Modify these spells to AOE and 30 yalms
entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 208 then -- Tornado
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setMPCost(1)
    end

    if spell:getID() == 245 then -- Drain
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setMPCost(1)
    end
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    mob:removeListener("WIND_WALL_BONUS")
    mob:removeListener("DEATH")
    mob:removeListener("ZEPHYR")
    mob:setLocalVar("[rage]timer", 1800)
	for _, despawnMob in ipairs(despawnMobTable) do
	    SpawnMob(despawnMob)
    end
    
    GetNPCByID(17961736):setStatus(xi.status.NORMAL) -- qm_seiryu
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:resetLocalVars()
    player:addTitle(xi.title.SEIRYU_CLIPPER)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    mob:removeListener("WIND_WALL_BONUS")
    mob:removeListener("DEATH")
    mob:removeListener("ZEPHYR")
end

return entity
