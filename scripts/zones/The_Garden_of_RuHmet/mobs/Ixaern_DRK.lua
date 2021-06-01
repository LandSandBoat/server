-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Ix'aern DRK
-- !pos -240 5.00 440 35
-- !pos -280 5.00 240 35
-- !pos -560 5.00 239 35
-- !pos -600 5.00 440 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(IxAernDrkMob)
    IxAernDrkMob:addListener("DEATH", "AERN_DEATH", function(mob)
        local timesReraised = mob:getLocalVar("AERN_RERAISES")
        if(math.random (1, 10) < 10) then
            -- reraise
            local target = mob:getTarget()
            local targetid = 0
            if target then
                targetid = target:getShortID()
            end
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
            mob:timer(9000, function(mobArg)
                mobArg:setHP(mob:getMaxHP())
                mobArg:setAnimationSub(3)
                mobArg:resetAI()
                mobArg:stun(3000)
                local new_target = mobArg:getEntity(targetid)
                if new_target and mobArg:checkDistance(new_target) < 40 then
                    mobArg:updateClaim(new_target)
                    mobArg:updateEnmity(new_target)
                end
                mobArg:triggerListener("AERN_RERAISE", mobArg, timesReraised)
            end)
        else
            -- death
            mob:setMobMod(xi.mobMod.NO_DROPS, 0)
            -- DespawnMob(QnAernA)
            -- DespawnMob(QnAernB)
        end
    end)

    IxAernDrkMob:addListener("AERN_RERAISE", "IX_DRK_RERAISE", function(mob, timesReraised)
        mob:setLocalVar("AERN_RERAISES", timesReraised + 1)
        mob:timer(5000, function(mobArg)
            mobArg:setAnimationSub(1)
        end)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(1)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.BLOOD_WEAPON_IXDRK,
                hpp = math.random(90, 95),
                cooldown = 120,
                endCode = function(mobArg)
                    mobArg:SetMagicCastingEnabled(false)
                    mobArg:timer(30000, function(mobTimerArg)
                        mobTimerArg:SetMagicCastingEnabled(true)
                    end)
                end,
            }
        }
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar("AERN_RERAISES", 0)
end

return entity
