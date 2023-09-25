-----------------------------------
-- Area: Horlais Peak
--  Mob: Aries
-- KSNM: Today's Horoscope
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 5)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 75)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 50)
    mob:setMod(xi.mod.STR, -15)
    mob:setMod(xi.mod.ATT, 215) -- Damage should be ~120-140 on a 75 RDM with 326 DEF
end

entity.onMobFight = function(mob, target)
    local sleepy = mob:getLocalVar("sleepyTime")
    local wakeyTime = mob:getLocalVar("Wakey")

    if sleepy == 1 then
        mob:showText(mob, ID.text.DEEP_SLEEP)
        mob:addStatusEffect(xi.effect.SLEEP_II, 1, 0, 300)
        mob:setLocalVar("sleepyTime", 2)
    end

    if sleepy == 2 or mob:hasStatusEffect(xi.effect.SLEEP_I) or mob:hasStatusEffect(xi.effect.SLEEP_II) or mob:hasStatusEffect(xi.effect.LULLABY) then
        mob:setMod(xi.mod.REGEN, math.random(50,150))
        mob:setMod(xi.mod.REGAIN, 500)
    end

    if mob:checkDistance(target) > 20 and mob:getLocalVar("sleepyTime") == 0 and mob:getBattleTime() > wakeyTime then
        mob:setLocalVar("sleepyTime", 1)
    end

    mob:addListener("EFFECT_LOSE", "SLEEP_EFFECT_LOSE", function(mobArg, effect)
        if effect:getType() == xi.effect.SLEEP_I or effect:getType() == xi.effect.SLEEP_II or effect:getType() == xi.effect.LULLABY then
            mobArg:setLocalVar("sleepyTime", 0)
            mobArg:setLocalVar("Wakey", mobArg:getBattleTime() + 5)
            mobArg:setMod(xi.mod.REGEN, 0)
            mobArg:setMod(xi.mod.REGAIN, 0)
            mobArg:setLocalVar("twohour_tp", mob:getTP())
            mobArg:useMobAbility(404)
            mob:addStatusEffect(xi.effect.HASTE, 25, 0, 30)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 269 then
        mob:setLocalVar("sleepyTime", 1)
    elseif skill:getID() == 404 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

entity.onMonsterMagicPrepare = function(mob, target)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 356
    end
end

return entity
