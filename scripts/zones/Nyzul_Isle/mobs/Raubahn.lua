-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Raubahn
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        mob:showText(mob, ID.text.CARVE)
    end)

    --[[ Todo:
        1. Missing reraise animations
        2. Logic for resist change is off (during test, 1st rr gained no resist..)
        3. Need a tracking var/thing on taking damage for the resist instead of that job check
        4. Find out why sometimes showText() is firing multiple times and sometimes not at all..
    ]]

    mob:addListener("DEATH", "RAUBAHN_DEATH", function(mob)
        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)

        local reraises = mob:getLocalVar("RERAISES")

        if (reraises < 2) then
            local target = mob:getTarget()
            local targetid = 0

            if target then targetid = target:getShortID() end

            mob:timer(12000, function(mob)
                mob:setHP(mob:getMaxHP())
                mob:AnimationSub(3)
                mob:resetAI()
                mob:stun(3000)
                local new_target = mob:getEntity(targetid)

                if new_target and mob:checkDistance(new_target) < 40 then
                    mob:updateClaim(new_target)
                    mob:updateEnmity(new_target)
                end

                mob:setLocalVar("RERAISES", reraises+1)
            end)

            -- AFAICT we lack the damage tracking for his immunity based on accumulated damage type
            -- Therefore, we'll guess based off of tallying player main jobs - which is better than nothing
            if (reraises == 1) then
                local ranged = 0
                local magic = 0
                local phys = 0

                local chars = mob:getInstance():getChars()

                for i, v in pairs(chars) do
                    local job = v:getMainJob()

                    if (job == 1 or job == 2 or (job >= 6 and job <= 10) or (job >=12 and job <=14) or (job >= 16 and job <=19 )) then
                        phys = phys + 1
                    elseif ((job >= 3 and job <= 5) or job == 15 or job == 20) then
                        magic = magic + 1
                    else
                        ranged = ranged + 1
                    end
                end

                -- RESIST message only shows for first reraise,
                -- 2nd reraise should use ID.text.NOW_UNDERSTAND instead
                if (phys >= magic and phys >= ranged) then
                    mob:showText(mob, ID.text.RESIST_MELEE)
                    mob:setMod(tpz.mod.UDMGPHYS, -100)
                elseif (magic >= phys and magic >= ranged) then
                    mob:showText(mob, ID.text.RESIST_MAGIC)
                    mob:addMod(tpz.mod.UDMGMAGIC, -100)
                else
                    mob:showText(mob, ID.text.RESIST_RANGE)
                    mob:addMod(tpz.mod.UDMGRANGE, -100)
                end
            end
        else
            -- We're out of raises, so we can go away now
            mob:setMobMod(tpz.mobMod.BEHAVIOR, 0)
        end
    end)

    -- We're able to be raised initially and shouldn't despawn
    mob:setMobMod(tpz.mobMod.BEHAVIOR, 5)
end

function onMobEngaged(mob, target)
    -- localVar because we don't want it to repeat every reraise.
    if (mob:getLocalVar("started") == 0) then
        mob:showText(mob, ID.text.PRAY)
        mob:setLocalVar("started", 1)
    end
end

function onMobFight(mob, target)
    --[[ Mob version of Azure Lore needs scripted, then we can remove this block commenting.
    -- On his 2nd and 3rd "lives" Raubahn will use Azure Lore at low health.
    local hpTrigger = mob:getLocalVar("AzureLoreHP")
    if (hpTrigger > 0) then -- It'll be zero on his first "life"
        local usedAzure = mob:getLocalVar("usedAzureLore")
        if (mob:getHPP() <= hpTrigger and usedAzure == 0) then
            mob:setLocalVar("usedAzureLore", 1)
            mob:setLocalVar("AzureLoreHP", math.random(20, 50) -- Re-rolling the % for next "life"
            mob:useMobAbility(tpz.jsa.AZURE_LORE)
        end
    end
    ]]
end

function onSpellPrecast(mob, spell)
    -- Eyes on Me
    if (spell == 641) then
        mob:showText(mob, ID.text.BEHOLD)
    end
end

function onMobDeath(mob, player, isKiller)
    -- If he's out of reraises, display text
    if (isKiller and mob:getMobMod(tpz.mobMod.BEHAVIOR) == 0) then
        mob:showText(mob, ID.text.MIRACLE)
    end
end
