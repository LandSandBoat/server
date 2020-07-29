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

function onMobInitialize(mob)
    mob:addListener("DEATH", "AERN_DEATH", function(mob)
        local timesReraised = mob:getLocalVar("AERN_RERAISES")
        if(math.random (1, 10) < 10) then
            -- reraise
            local target = mob:getTarget()
            local targetid = 0
            if target then
                targetid = target:getShortID()
            end
            mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
            mob:timer(9000, function(mob)
                mob:setHP(mob:getMaxHP())
                mob:AnimationSub(3)
                mob:resetAI()
                mob:stun(3000)
                local new_target = mob:getEntity(targetid)
                if new_target and mob:checkDistance(new_target) < 40 then
                    mob:updateClaim(new_target)
                    mob:updateEnmity(new_target)
                end
                mob:triggerListener("AERN_RERAISE", mob, timesReraised)
            end)
        else
            -- death
            mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
            DespawnMob(QnAernA)
            DespawnMob(QnAernB)
        end
    end)
    mob:addListener("AERN_RERAISE", "IX_DRK_RERAISE", function(mob, timesReraised)
        mob:setLocalVar("AERN_RERAISES", timesReraised + 1)
        mob:timer(5000, function(mob)
            mob:AnimationSub(1)
        end)
    end)
end

function onMobSpawn(mob)
    mob:AnimationSub(1)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.BLOOD_WEAPON_IXDRK,
                hpp = math.random(90, 95),
                cooldown = 120,
                endCode = function(mob)
                    mob:SetMagicCastingEnabled(false)
                    mob:timer(30000, function(mob)
                        mob:SetMagicCastingEnabled(true)
                    end)
                end,
            }
        }
    })
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("AERN_RERAISES", 0)
end
