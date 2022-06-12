-- Aern family mixin
-- Customization:
--   Setting AERN_RERAISE_MAX will determine the number of times it will reraise.
--   By default, this will be 1 40% of the time and 0 the rest (ie. default aern behaviour).
--   For multiple reraises, this can be set on spawn for more reraises.
--   To run a function when a reraise occurs, add a listener to AERN_RERAISE

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.aern = function(aernMob)
    aernMob:addListener("DEATH", "AERN_DEATH", function(mob, killer)
        if killer then
            local reraises = mob:getLocalVar("AERN_RERAISE_MAX")
            local curr_reraise = mob:getLocalVar("AERN_RERAISES")
            if reraises == 0 then
                if math.random() < 0.4 then
                    reraises = 1
                end
            end
            mob:setMobMod(xi.mobMod.NO_DROPS, 0) -- Drops on if Not reraising
            if curr_reraise < reraises then
                mob:setMobMod(xi.mobMod.NO_DROPS, 1)  -- Drops off if reraising
                local dropid = mob:getDropID()
                local owner = nil
                local target = mob:getTarget()
                if
                    target:isPet() and
                    not target:isAlive()
                then
                    target = target:getMaster()
                end
                mob:timer(12000, function(mobArg)
                    mobArg:setHP(mob:getMaxHP())
                    mobArg:setDropID(dropid)
                    mobArg:setAnimationSub(3)
                    mobArg:setLocalVar("AERN_RERAISES", curr_reraise + 1)
                    mobArg:resetAI()
                    mobArg:stun(3000)
                    if
                        mobArg:checkDistance(target) < 40 and
                        target:isAlive()
                    then
                        mobArg:updateClaim(target)
                        mobArg:updateEnmity(target)
                    else
                        local partySize = killer:getPartySize() -- Check for other available valid aggro targets
                        local i = 1
                        if killer ~= nil then
                            for _, partyMember in pairs(killer:getAlliance()) do
                                if partyMember:isAlive() and mobArg:checkDistance(partyMember) < 40 then
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
                    mobArg:triggerListener("AERN_RERAISE", mobArg, curr_reraise + 1)
                end)
            end
        end
    end)
end

return g_mixins.families.aern
