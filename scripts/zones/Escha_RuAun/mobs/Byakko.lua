-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Byakko
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}
local despawnMobTable =
{
    17961219,
    17961220,
    17961221,
    17961222,
    17961223,
    17961224,
    17961225,
    17961226,
}

entity.onMobSpawn = function(mob ,target)
    mob:addListener("WEAPONSKILL_TAKE", "ATONEMENT_HATE_RESET", function(mobArg, user, wsid)
        if wsid == 45 then
            mob:resetEnmity(user)

            mob:timer(5000, function(mobArg)
                local enmityList = mobArg:getEnmityList()
				local numEntries = #enmityList
				
				killPlayer = utils.randomEntry(enmityList)["entity"]
				if killPlayer then
				    killPlayer:setHP(0)
				end
            end)
        end
    end)

    mob:addListener("MAGIC_TAKE", "ENFEEBLING_DEATH", function(target, caster, spell)
        if spell:getSkillType() == xi.skill.ENFEEBLING_MAGIC and spell:getID() ~= 59 then  -- Silence

            mob:timer(5000, function(mobArg)
                local enmityList = mobArg:getEnmityList()
				local numEntries = #enmityList
				
				killPlayer = utils.randomEntry(enmityList)["entity"]
				if killPlayer then
				    killPlayer:setHP(0)
				end
            end)
        end
    end)
	
	if mob:hasStatusEffect(xi.effect.SILENCE) then
	    mob:useMobAbility(689) -- Benediction
	end	

    xi.mix.jobSpecial.config(mob, {
        between = 240, -- 4 min PD timer
        specials =
        {		
            {id = xi.jsa.PERFECT_DODGE, cooldown = 0, hpp = 100},			
        },
    })
	
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 70)
    mob:addMod(xi.mod.INT, 60)
    mob:addMod(xi.mod.MND, 120)
    mob:addMod(xi.mod.CHR, 120)
    mob:addMod(xi.mod.AGI, 40)
    mob:addMod(xi.mod.DEX, 50)
    mob:addMod(xi.mod.DEFP, 30)
    mob:addMod(xi.mod.RATTP, 80)
    mob:addMod(xi.mod.ACC, 100)
    mob:setMod(xi.mod.CRITHITRATE, 30)
    mob:setMod(xi.mod.CRIT_DMG_INCREASE, 20)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 20)      
    mob:setMod(xi.mod.SILENCERES, 9999)
    mob:setMod(xi.mod.STUNRES, 9999)
    mob:setMod(xi.mod.BINDRES, 9999)
    mob:setMod(xi.mod.GRAVITYRES, 9999)
    mob:setMod(xi.mod.SLEEPRES, 9999)
    mob:setMod(xi.mod.POISONRES, 9999)
    mob:setMod(xi.mod.PARALYZERES, 9999)
    mob:setMod(xi.mod.LULLABYRES, 9999)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 75)
    mob:setMod(xi.mod.EARTH_MEVA, 250)
    mob:setMod(xi.mod.DARK_MEVA, 128)
    mob:setMod(xi.mod.LIGHT_MEVA, 200)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.WATER_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 350)
    mob:setMod(xi.mod.WIND_MEVA, 250)
    mob:setMod(xi.mod.ICE_MEVA, 350)
    mob:setMod(xi.mod.EARTH_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.WATER_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 350)
    mob:setMod(xi.mod.ICE_SDT, 350)
    mob:setMod(xi.mod.WIND_SDT, 250)
    mob:setMod(xi.mod.LIGHT_ABSORB, 200)
    mob:setMod(xi.mod.FASTCAST, 550)
    mob:addStatusEffect(xi.effect.REGEN, 70, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REGAIN, 50, 3, 0)
    mob:addStatusEffect(xi.effect.BLOOD_WEAPON, 1, 0, 0)		
	mob:setDropID(3991)
end

entity.onMobFight = function(mob, target)
    local lifePercent = mob:getHPP()
    local twoHourUsed = mob:getLocalVar("twoHourUsed")	

    if lifePercent <= 60 and lifePercent >= 50 and twoHourUsed == 0 then
        mob:useMobAbility(731) --MIJIN_GAKURE
		mob:setLocalVar("twoHourUsed", 1)
    end

    if lifePercent <= 30 and lifePercent >= 20 and twoHourUsed == 1 then
        mob:useMobAbility(731) --MIJIN_GAKURE
		mob:setLocalVar("twoHourUsed", 2)
    end
	
    if lifePercent <= 10 and lifePercent >= 5 and twoHourUsed == 2 then
        mob:useMobAbility(731) --MIJIN_GAKURE
		mob:setLocalVar("twoHourUsed", 3)
    end

	if lifePercent >= 62 and twoHourUsed >= 1 then
	    mob:resetLocalVars()
    end

    if lifePercent >= 32 and twoHourUsed == 2 then
        mob:resetLocalVars()
    end
	
    if lifePercent >= 12 and twoHourUsed == 3 then
        mob:resetLocalVars()
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENLIGHT)
end

entity.onMobDisengage = function(mob, player)
    mob:resetLocalVars()
end

entity.onMobRoam = function(mob)
    mob:resetLocalVars()
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:resetLocalVars()
end

entity.onMobDespawn = function(mob)
end

return entity
