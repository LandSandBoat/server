-- Aern family mixin
-- Customization:
--   Setting AERN_RERAISE_MAX will determine the number of times it will reraise.
--   By default, this will be 1 40% of the time and 0 the rest (ie. default aern behaviour).
--   For multiple reraises, this can be set on spawn for more reraises.
--   To run a function when a reraise occurs, add a listener to AERN_RERAISE

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.aern = function(aernMob)
    aernMob:addListener('DEATH', 'AERN_DEATH', function(mob, killer)
        if not killer then
            return
        end

        local reraises = mob:getLocalVar('AERN_RERAISE_MAX')
        local currReraise = mob:getLocalVar('AERN_RERAISES')
        if reraises == 0 then
            reraises = 1
        end

        if currReraise >= reraises or utils.chance(60) then
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
            if target == nil then
                -- try mob
                target = GetEntityByID(targetID, mobArg:getInstance(), true)
            end

            if target == nil and masterID ~= 0 then
                target = GetPlayerByID(masterID)
                if target == nil then
                    -- try mob
                    target = GetEntityByID(masterID, mobArg:getInstance(), true)
                end
            end

            mobArg:setHP(mob:getMaxHP())
            mobArg:setAnimationSub(3)
            mobArg:setLocalVar('AERN_RERAISES', currReraise + 1)
            mobArg:resetAI()
            mobArg:stun(3000)
            if
                target and
                mobArg:checkDistance(target) < 25 and
                target:isAlive()
            then
                mobArg:updateClaim(target)
                mobArg:updateEnmity(target)
            else
                local partySize = killer:getPartySize() -- Check for other available valid aggro targets
                local i = 1
                if killer ~= nil then
                    for _, partyMember in pairs(killer:getAlliance()) do --TODO add enmity list check when binding avail
                        if partyMember:isAlive() and mobArg:checkDistance(partyMember) < 25 then
                            mobArg:updateClaim(partyMember)
                            mobArg:updateEnmity(partyMember)
                            break
                        elseif i == partySize then --if all checks fail just disengage
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
