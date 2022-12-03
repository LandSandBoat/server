-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Raubahn
-----------------------------------
local ID = require('scripts/zones/Nyzul_Isle/IDs')
require('scripts/globals/status')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mobArg, skillID)
        mob:showText(mobArg, ID.text.CARVE)
    end)

    --[[ Todo:
        1. Missing reraise animations
        2. Logic for resist change is off (during test, 1st rr gained no resist..)
        3. Need a tracking var/thing on taking damage for the resist instead of that job check
        4. Find out why sometimes showText() is firing multiple times and sometimes not at all..
    ]]

    mob:addListener("DEATH", "RAUBAHN_DEATH", function(mobArg)
        local instance = mobArg:getInstance()
        instance:setProgress(instance:getProgress() + 1)

        local reraises = mobArg:getLocalVar("RERAISES")

        if reraises < 2 then
            local target   = mobArg:getTarget()
            local targetid = 0

            if target then
                targetid = target:getTargID()
            end

            mobArg:timer(12000, function(mobTimerArg)
                mobTimerArg:setHP(mobTimerArg:getMaxHP())
                mobTimerArg:setAnimationSub(3)
                mobTimerArg:resetAI()
                mobTimerArg:stun(3000)
                local newTarget = mobTimerArg:getEntity(targetid)

                if newTarget and mobTimerArg:checkDistance(newTarget) < 40 then
                    mobTimerArg:updateClaim(newTarget)
                    mobTimerArg:updateEnmity(newTarget)
                end

                mobTimerArg:setLocalVar("RERAISES", reraises + 1)
            end)

            -- AFAICT we lack the damage tracking for his immunity based on accumulated damage type
            -- Therefore, we'll guess based off of tallying player main jobs - which is better than nothing
            if reraises == 1 then
                local ranged = 0
                local magic  = 0
                local phys   = 0

                local chars = mobArg:getInstance():getChars()

                for i, v in pairs(chars) do
                    local job = v:getMainJob()

                    if
                        job == 1 or
                        job == 2 or
                        (job >= 6 and job <= 10) or
                        (job >= 12 and job <= 14) or
                        (job >= 16 and job <= 19)
                    then
                        phys = phys + 1
                    elseif
                        (job >= 3 and job <= 5) or
                        job == 15 or
                        job == 20
                    then
                        magic = magic + 1
                    else
                        ranged = ranged + 1
                    end
                end

                -- RESIST message only shows for first reraise,
                -- 2nd reraise should use ID.text.NOW_UNDERSTAND instead
                if phys >= magic and phys >= ranged then
                    mobArg:showText(mobArg, ID.text.RESIST_MELEE)
                    mobArg:setMod(xi.mod.UDMGPHYS, -10000)
                elseif magic >= phys and magic >= ranged then
                    mobArg:showText(mobArg, ID.text.RESIST_MAGIC)
                    mobArg:addMod(xi.mod.UDMGMAGIC, -10000)
                else
                    mobArg:showText(mobArg, ID.text.RESIST_RANGE)
                    mobArg:addMod(xi.mod.UDMGRANGE, -10000)
                end
            end
        else
            -- We're out of raises, so we can go away now
            mobArg:setMobMod(xi.mobMod.BEHAVIOR, 0)
        end
    end)

    -- We're able to be raised initially and shouldn't despawn
    mob:setMobMod(xi.mobMod.BEHAVIOR, 5)
end

entity.onMobEngaged = function(mob, target)
    -- localVar because we don't want it to repeat every reraise.
    if mob:getLocalVar("started") == 0 then
        mob:showText(mob, ID.text.PRAY)
        mob:setLocalVar("started", 1)
    end
end

entity.onMobFight = function(mob, target)
    --[[ Mob version of Azure Lore needs scripted, then we can remove this block commenting.
    -- On his 2nd and 3rd "lives" Raubahn will use Azure Lore at low health.
    local hpTrigger = mob:getLocalVar("AzureLoreHP")
    if (hpTrigger > 0) then -- It'll be zero on his first "life"
        local usedAzure = mob:getLocalVar("usedAzureLore")
        if mob:getHPP() <= hpTrigger and usedAzure == 0 then
            mob:setLocalVar("usedAzureLore", 1)
            mob:setLocalVar("AzureLoreHP", math.random(20, 50) -- Re-rolling the % for next "life"
            mob:useMobAbility(xi.jsa.AZURE_LORE)
        end
    end
    ]]
end

entity.onSpellPrecast = function(mob, spell)
    -- Eyes on Me
    if spell == 641 then
        mob:showText(mob, ID.text.BEHOLD)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- If he's out of reraises, display text
    if optParams.isKiller and mob:getMobMod(xi.mobMod.BEHAVIOR) == 0 then
        mob:showText(mob, ID.text.MIRACLE)
    end
end

return entity
