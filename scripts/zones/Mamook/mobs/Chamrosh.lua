-----------------------------------
-- Area: Mamook
--  ZNM: Chamrosh (Tier-1 ZNM)
-- Does not use normal colibri mimic mechanics, changes form every
-- 2.5 mins. st form mimics all spells 2nd form cast spells from list only
-- todo: when mimics a spell will cast the next tier spell
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- TODO INITIAL COMMIT Just put here so players cannot run through the NM's 
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.SLEEPRES, 30)
    mob:addMod(xi.mod.BINDRES, 30)
    mob:addMod(xi.mod.GRAVITYRES, 30)
    mob:addMod(xi.mod.ATT, 200)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.MDEF, 150)
    mob:addMod(xi.mod.DEF, 100)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 50)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DEFP, 50)
    mob:addMod(xi.mod.DEFP, 475)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_RES, 170)
    mob:setMod(xi.mod.DARK_RES, 250)
    mob:setMod(xi.mod.LIGHT_RES, 128)
    mob:setMod(xi.mod.FIRE_RES, 170)
    mob:setMod(xi.mod.WATER_RES, 170)
    mob:setMod(xi.mod.THUNDER_RES, 170)
    mob:setMod(xi.mod.ICE_RES, 200)
    mob:setMod(xi.mod.WIND_RES, 170)
	mob:setMod(xi.mod.EARTH_SDT, 170)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.FIRE_SDT, 170)
    mob:setMod(xi.mod.WATER_SDT, 170)
    mob:setMod(xi.mod.THUNDER_SDT, 170)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 170)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 10, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("changeTime", 150)
    mob:setLocalVar("useWise", math.random(25, 50))
    mob:addMod(xi.mod.UFASTCAST, 150)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar("delay")
    local LastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")
    local changeTime = mob:getLocalVar("changeTime")

    if spell > 0 and mob:hasStatusEffect(xi.effect.SILENCE) == false then
        if delay >= 3 then
            mob:castSpell(spell)
            mob:setLocalVar("COPY_SPELL", 0)
            mob:setLocalVar("delay", 0)
        else
            mob:setLocalVar("delay", delay+1)
        end
    end
    if mob:getHPP() < mob:getLocalVar("useWise") and mob:getLocalVar("usedMainSpec") == 0 then
        mob:useMobAbility(1702)
        mob:setLocalVar("usedMainSpec", 1)
    end
    if mob:getBattleTime() == changeTime then
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
            mob:setSpellList(0)
            mob:setLocalVar("changeTime", mob:getBattleTime() + 150)
        else
            mob:setAnimationSub(0)
            mob:setSpellList(302)
            mob:setLocalVar("changeTime", mob:getBattleTime() + 150)
        end
    end
end

entity.onMagicHit = function(caster, target, spell)
    if spell:tookEffect() and target:getAnimationSub() == 1 and (caster:isPC() or caster:isPet()) then
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
    end

    return 1
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
