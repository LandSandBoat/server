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

entity.onMobSpawn = function(mob ,target)
    mob:addListener("WEAPONSKILL_TAKE", "ATONEMENT_HATE_RESET", function(mobArg, user, wsid)
        if wsid == 45 then
            print("used atonement")
            mob:resetEnmity(user)

            mob:timer(5000, function(mobArg)
                print("trying to kill someone")
                local allianceMembers = user:getAlliance()
                -- print(user:getAlliance())
                for k in pairs(allianceMembers) do
                    table.insert(keyset, k)
                end
                print("assigning randomplayer")
                local randomPlayer = allianceMembers[keyset[math.random(#keyset)]]
                print(randomPlayer)
                randomPlayer:setHP(0)
            end)
        end
    end)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = xi.jsa.CHAINSPELL, cooldown = 0, hpp = 100},
            {id = xi.jsa.PERFECT_DODGE, cooldown = 0, hpp = 100},
            {id = xi.jsa.BENEDICTION, cooldown = 0, hpp = 100},
        },
    })
        mob:setMobMod(xi.mobMod.DRAW_IN, 2)    
        mob:addMod(xi.mod.STR, 50)
        mob:addMod(xi.mod.VIT, 70)
        mob:addMod(xi.mod.INT, 60)
        mob:addMod(xi.mod.MND, 120)
        mob:addMod(xi.mod.CHR, 70)
        mob:addMod(xi.mod.AGI, 40)
        mob:addMod(xi.mod.DEX, 50)
        mob:addMod(xi.mod.DEFP, 80)
        mob:addMod(xi.mod.RATTP, 80)
        mob:addMod(xi.mod.ACC, 100)
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
        mob:setMod(xi.mod.FASTCAST, 20)
        mob:addStatusEffect(xi.effect.REGEN, 50, 3, 0)
        mob:addStatusEffect(xi.effect.REFRESH, 30, 3, 0)
        mob:addStatusEffect(xi.effect.REGAIN, 30, 3, 0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENLIGHT)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity
