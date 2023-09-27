-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/mobskills")
-----------------------------------
local entity = {}
local counter = 0
local despawnMobTable =
{
    17961162,
    17961163,
    17961164,
    17961165,
    17961166,
    17961167,
    17961168,
    17961169
}

entity.onMobSpawn = function(mob, target)
    local fiveStepCounter = 0
    mob:addListener("WEAPONSKILL_TAKE", "FIVE_STEP_SC", function(mobArg, user, wsid)
        if (wsid == 148 or wsid == 150 or wsid == 151) and mob:getStatusEffect(xi.effect.SKILLCHAIN) then -- Jinpu/Kasha/Gekko
            mob:setLocalVar("fiveStepTimer", 1)
            print("5 step timer started")
            if fiveStepCounter < 5 and mob:getLocalVar("fiveStepTimer") == 1 then
                fiveStepCounter = fiveStepCounter + 1
                print(string.format("registered tachi:jinpu, %s.", fiveStepCounter))
            end
            
            if fiveStepCounter == 5 then
                print("Genbu has been procced!")
                mob:weaknessTrigger(3)
                mob:removeListener("FIVE_STEP_SC")
                mob:delMod(xi.mod.STUNRES, 9999)
                mob:delMod(xi.mod.MAIN_DMG_RATING, 10)
                mob:delMod(xi.mod.PARALYZERES, 9999)
                mob:delMod(xi.mod.POISONRES, 9999)
                mob:delMod(xi.mod.THUNDER_MEVA, 300)
                fiveStepCounter = 0
            end

            mob:timer(20000, function(mobArg)
                mob:setLocalVar("fiveStepTimer", 0)
                fiveStepCounter = 0
                print("five step timer elapsed")
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
    mob:addMod(xi.mod.DEF, 100)
    mob:addMod(xi.mod.RATTP, 70)
    mob:addMod(xi.mod.ACC, 100)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.CRITHITRATE, 15)
    mob:setMod(xi.mod.CRIT_DMG_INCREASE, 15)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 20)
    mob:setMod(xi.mod.SILENCERES, 9999)
    mob:setMod(xi.mod.STUNRES, 9999)
    mob:setMod(xi.mod.BINDRES, 9999)
    mob:setMod(xi.mod.SLEEPRES, 9999)
    mob:setMod(xi.mod.POISONRES, 9999)
    mob:setMod(xi.mod.PARALYZERES, 9999)
    mob:setMod(xi.mod.LULLABYRES, 9999)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.EARTH_MEVA, 50)
    mob:setMod(xi.mod.DARK_MEVA, 50)
    mob:setMod(xi.mod.LIGHT_MEVA, 50)
    mob:setMod(xi.mod.FIRE_MEVA, 50)
    mob:setMod(xi.mod.WATER_MEVA, 50)
    mob:setMod(xi.mod.THUNDER_MEVA, 300)
    mob:setMod(xi.mod.WIND_MEVA, 50)
    mob:setMod(xi.mod.ICE_MEVA, 50)
    mob:setMod(xi.mod.EARTH_SDT, 10)
    mob:setMod(xi.mod.LIGHT_SDT, 10)
    mob:setMod(xi.mod.FIRE_SDT, 10)
    mob:setMod(xi.mod.WATER_SDT, 10)
    mob:setMod(xi.mod.THUNDER_SDT, 10)
    mob:setMod(xi.mod.ICE_SDT, 10)
    mob:setMod(xi.mod.WIND_SDT, 10)
    mob:setMod(xi.mod.LIGHT_ABSORB, 20)
    -- mob:setMod(xi.mod.FASTCAST, 20)
    mob:addStatusEffect(xi.effect.REGEN, 15, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 10, 3, 0)
    mob:addStatusEffect(xi.effect.REGAIN, 10, 3, 0)
    for _, despawnMob in ipairs(despawnMobTable) do
        DespawnMob(despawnMob)
    end
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
    for _, despawnMob in ipairs(despawnMobTable) do
        SpawnMob(despawnMob)
    end

    GetNPCByID(17961733):setStatus(xi.status.NORMAL) -- qm_genbu
end

return entity
