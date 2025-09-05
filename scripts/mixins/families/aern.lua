-- Aern family mixin
-- Customization:
--   Setting AERN_RERAISE_MAX will determine the number of times it will reraise.
--   By default, this will be 1 40% of the time and 0 the rest (ie. default aern behavior).
--   For multiple reraises, this can be set on spawn for more reraises.
--   To run a function when a reraise occurs, add a listener to AERN_RERAISE

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.aern = function(aernMob)
    local petDeath = function(mob)
        local pet = mob:getPet()
        if pet then
            pet:addListener('DEATH', 'AERN_PET_DEATH', function(petMob, player, optParams)
                local master = petMob:getMaster()
                if master and master:isAlive() and master:isEngaged() then
                    master:setLocalVar('petRespawnTime', GetSystemTime() + 30)
                end
            end)
        end
    end

    -- Aerns only spawn on engage, we need to manually control the spawn behavior with a summoning animation
    local petSpawn = function(mob)
        -- Don't spawn a pet if the mob already has one
        if mob:hasPet() then
            return
        end

        local mainJob = mob:getMainJob()

        if mainJob == xi.job.SMN then
            -- SMN Aerns only spawn 5 elementals
            local eleCount = mob:getLocalVar('aernElementalCount')
            if eleCount <= 5 then
                local elemental = math.random(xi.magic.spell.FIRE_SPIRIT, xi.magic.spell.DARK_SPIRIT)
                mob:castSpell(elemental, mob)
                mob:setLocalVar('aernElementalCount', eleCount + 1)

                -- Add death listener to elemental when it spawns
                mob:timer(1000, function(mobArg)
                    petDeath(mobArg)
                end)
            end
        elseif mainJob == xi.job.BST or mainJob == xi.job.DRG then
            mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:timer(3000, function(mobArg)
                mobArg:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
                mobArg:setAutoAttackEnabled(true)
                mobArg:setMobAbilityEnabled(true)
                mobArg:setMobMod(xi.mobMod.NO_MOVE, 0)
                mobArg:spawnPet()

                -- Add death listener to pet when it spawns
                mobArg:timer(1000, function(masterMob)
                    petDeath(masterMob)
                end)
            end)
        end
    end

    -- Bracelets activate after 80 seconds or 300 damage taken.
    -- They last for 30 seconds and give a 30% attack boost, +40 acc, and 33% delay reduction.
    local function toggleBracelets(mob)
        local braceletActive = mob:getLocalVar('braceletActive')

        if braceletActive == 0 then
            mob:setLocalVar('braceletTimer', GetSystemTime() + 30)
            mob:setLocalVar('braceletActive', 1)
            mob:setAnimationSub(2)
            mob:addMod(xi.mod.ATTP, 30)
            mob:addMod(xi.mod.DELAYP, -33)
            mob:addMod(xi.mod.ACC, 40)
        elseif braceletActive == 1 then
            mob:setLocalVar('braceletTimer', GetSystemTime() + 80)
            mob:setLocalVar('braceletActive', 0)
            mob:setLocalVar('braceletDamageTaken', 0)
            mob:setAnimationSub(1)
            mob:delMod(xi.mod.ACC, 40)
            mob:delMod(xi.mod.ATTP, 30)
            mob:delMod(xi.mod.DELAYP, -33)
        end
    end

    -- Prevent BSTs and SMNs from summoning pets while idle
    aernMob:addListener('SPAWN', 'AERN_SPAWN', function(mob)
        if mob:getMainJob() == xi.job.BST then
            mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
        elseif mob:getMainJob() == xi.job.SMN then
            mob:setSpellList(0)
        end
    end)

    aernMob:addListener('ENGAGE', 'AERN_ENGAGE', function(mob)
        local petJobs = { xi.job.BST, xi.job.DRG, xi.job.SMN }
        mob:setLocalVar('braceletTimer', GetSystemTime() + 80)
        mob:setMagicCastingEnabled(true) -- Enable casting when engaged

        if utils.contains(mob:getMainJob(), petJobs) then
            mob:timer(3000, function(mobArg)
                petSpawn(mobArg)
            end)
        end
    end)

    -- Despawn pets when Aern is out of combat
    aernMob:addListener('ROAM_TICK', 'AERN_ROAM', function(mob)
        mob:setMagicCastingEnabled(false) -- Disable casting when idle
        mob:setAnimationSub(1)

        local pet = mob:getPet()
        if pet and pet:isSpawned() then
            DespawnMob(pet:getID())
        end

        if mob:getMainJob() == xi.job.BST then
            mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
        elseif mob:getMainJob() == xi.job.SMN then
            mob:setSpellList(0)
        end
    end)

    aernMob:addListener('COMBAT_TICK', 'AERN_COMBAT_TICK', function(mob)
        -- Pet respawn check
        local petRespawnTime = mob:getLocalVar('petRespawnTime')

        if
            petRespawnTime > 0 and
            GetSystemTime() >= petRespawnTime and
            (not mob:hasPet() or mob:getPet() == nil) and
            (mob:getMainJob() == xi.job.BST or
            mob:getMainJob() == xi.job.SMN)
        then
            mob:setLocalVar('petRespawnTime', 0) -- Clear the timer
            petSpawn(mob)
        end

        -- Bracelet activation check
        local braceletTimer = mob:getLocalVar('braceletTimer')

        if GetSystemTime() > braceletTimer then
            toggleBracelets(mob)
        end
    end)

    aernMob:addListener('TAKE_DAMAGE', 'AERN_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)
        local braceletActive = mob:getLocalVar('braceletActive')

        -- Only track damage if not already using bracelets
        if braceletActive == 0 then
            local damageTaken = mob:getLocalVar('braceletDamageTaken')
            damageTaken = damageTaken + amount
            mob:setLocalVar('braceletDamageTaken', damageTaken)

            -- Check if 300 damage threshold reached
            if damageTaken >= 300 then
                toggleBracelets(mob)
            end
        end
    end)

    aernMob:addListener('DEATH', 'AERN_DEATH', function(mob, killer)
        if not killer then
            return
        end

        local reraises    = mob:getLocalVar('AERN_RERAISE_MAX')
        local currReraise = mob:getLocalVar('AERN_RERAISES')

        if reraises == 0 then
            reraises = 1
        end

        if
            currReraise >= reraises or
            math.random(1, 100) <= 60
        then
            mob:setMobMod(xi.mobMod.NO_DROPS, 0)

            return
        end

        if mob:getLocalVar('ALLOW_DROPS') == 0 then
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        end

        local target   = mob:getTarget()
        local targetID = 0
        local masterID = 0

        if target then
            targetID = target:getID()
        end

        if target:isPet() and target:getMaster() then
            masterID = target:getMaster():getID()
        end

        mob:timer(12000, function(mobArg)
            target = GetPlayerByID(targetID)

            if not target then
                -- try mob
                target = GetEntityByID(targetID, mobArg:getInstance(), true)
            end

            if
                not target and
                masterID > 0
            then
                target = GetPlayerByID(masterID)

                if not target then
                    -- try mob
                    target = GetEntityByID(masterID, mobArg:getInstance(), true)
                end
            end

            mobArg:setHP(mob:getMaxHP())
            mobArg:setAnimationSub(3)
            mobArg:setLocalVar('AERN_RERAISES', currReraise + 1)
            mobArg:resetAI()
            mobArg:stun(3000)

            if mob:getMainJob() == xi.job.SMN then
                mob:setLocalVar('aernElementalCount', 0)
            end

            if
                target and
                mobArg:checkDistance(target) < 25 and
                target:isAlive()
            then
                mobArg:updateClaim(target)
                mobArg:updateEnmity(target)
            else
                local partySize = killer:getPartySize() -- Check for other available valid aggro targets
                local i         = 1

                if killer then
                    for _, partyMember in pairs(killer:getAlliance()) do --TODO add enmity list check when binding avail
                        -- Engage
                        if partyMember:isAlive() and mobArg:checkDistance(partyMember) < 25 then
                            mobArg:updateClaim(partyMember)
                            mobArg:updateEnmity(partyMember)

                            break

                        -- Disengage.
                        elseif i == partySize then
                            mobArg:disengage()
                        end

                        i = i + 1
                    end
                else
                    mobArg:disengage()
                end
            end

            mobArg:triggerListener('AERN_RERAISE', mobArg, currReraise + 1)
        end)

        mob:timer(16000, function(mobArg)
            mobArg:setAnimationSub(1)
        end)
    end)
end

return g_mixins.families.aern
