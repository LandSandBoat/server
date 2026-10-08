-----------------------------------
-- Apkallu emergence on the Silver Sea ferries.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
-----------------------------------

g_mixins.ferry_apkallu = function(mob)
    -- Spawn already in the hidden pose so it never flickers into view first.
    mob:setMobMod(xi.mobMod.SPAWN_ANIMATIONSUB, 6)

    mob:addListener('SPAWN', 'FERRY_APKALLU_SPAWN', function(mobArg)
        -- Emerge onto the ferry: hidden (sub 6) and untargetable, then surface into
        -- the resting pose (sub 5) and become visible and targetable.
        mobArg:hideName(true)
        mobArg:setUntargetable(true)
        mobArg:setAnimationSub(6)
        mobArg:stun(3000)

        mobArg:timer(3000, function(mobTimerArg)
            if not mobTimerArg:isAlive() then
                return
            end

            -- Stay still through the visible emergence; combat can interrupt this wait.
            mobTimerArg:wait(7000)
            mobTimerArg:setAnimationSub(5)
            mobTimerArg:hideName(false)
            mobTimerArg:setUntargetable(false)
        end)
    end)
end

return g_mixins.ferry_apkallu
