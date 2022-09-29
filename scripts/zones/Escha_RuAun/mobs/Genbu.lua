-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    mob:addListener("MAGIC_TAKE", "DIE_BITCH", function(target, caster, spell)
        if spell:getElement() == VanadielDayElement() then

            mob:timer(500, function(mobArg)
                for _, partyMember in pairs(caster:getAlliance()) do
	                partyMember:PrintToPlayer(string.format("%s's carelessness has filled %s with unfathomable rage!", caster:getName(), mob:getName(), 0xD))
                    partyMember:injectActionPacket(partyMember:getID(), 11, 200, 0, 0, 0, 0, 0) -- burning animation
				end
            end)
            
            mob:timer(5000, function(mobArg)
                for _, partyMember in pairs(caster:getAlliance()) do -- kill everyone
                    partyMember:setHP(0)
                end
            end)
        end
    end)
    
    mob:addListener("MAGIC_TAKE", "FLASH_CHARM", function(target, caster, spell)
        if spell:getID() == 112 then -- flash

            mob:timer(500, function(mobArg)
                caster:injectActionPacket(caster:getID(), 11, 200, 0, 0, 0, 0, 0) -- burning animation
            end)
            
            mob:timer(5000, function(mobArg)
                mobArg:useMobAbility(1702) -- Wisecrack (AoE charm)
            end)
        end
    end)
	
    xi.mix.jobSpecial.config(mob, {
        between = 90,
        specials =
        {
            {id = xi.jsa.INVINCIBLE, cooldown = 0, hpp = 100},
            {id = xi.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 100},
        },
    })

    mob:setMobMod(xi.mobMod.DRAW_IN, 2)    
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 70)
    mob:addMod(xi.mod.INT, 60)
    mob:addMod(xi.mod.MND, 80)
    mob:addMod(xi.mod.CHR, 70)
    mob:addMod(xi.mod.AGI, 40)
    mob:addMod(xi.mod.DEX, 50)
    mob:addMod(xi.mod.DEFP, 80)
    mob:addMod(xi.mod.RATTP, 70)
    mob:addMod(xi.mod.ACC, 100)
	mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.CRITHITRATE, 30)
    mob:setMod(xi.mod.CRIT_DMG_INCREASE, 50)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 50)        
    mob:setMod(xi.mod.SILENCERES, 9999)
    mob:setMod(xi.mod.STUNRES, 9999)
    mob:setMod(xi.mod.BINDRES, 9999)
    mob:setMod(xi.mod.GRAVITYRES, 9999)
    mob:setMod(xi.mod.SLEEPRES, 9999)
    mob:setMod(xi.mod.POISONRES, 9999)
    mob:setMod(xi.mod.PARALYZERES, 9999)
    mob:setMod(xi.mod.LULLABYRES, 9999)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.EARTH_MEVA, 250)
    mob:setMod(xi.mod.DARK_MEVA, 128)
    mob:setMod(xi.mod.LIGHT_MEVA, 200)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.WATER_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 250)
    mob:setMod(xi.mod.WIND_MEVA, 250)
    mob:setMod(xi.mod.ICE_MEVA, 250)
    mob:setMod(xi.mod.EARTH_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.WATER_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 250)
    mob:setMod(xi.mod.ICE_SDT, 250)
    mob:setMod(xi.mod.WIND_SDT, 250)    
    mob:setMod(xi.mod.LIGHT_ABSORB, 200)
    -- mob:setMod(xi.mod.FASTCAST, 20)
    mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REGAIN, 30, 3, 0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobFight = function(mob, target)
    if target:hasStatusEffect(xi.effect.COPY_IMAGE) then
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:injectActionPacket(target:getID(), 11, 200, 0, 0, 0, 0, 0) -- splash animation
		target:PrintToPlayer("Genbu removes your remaining shadows...")
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity
