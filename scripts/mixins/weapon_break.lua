require('scripts/globals/mixins')

g_mixins = g_mixins or {}

-- AnimationSub
-- 0 = main weapon out
-- 1 = main weapon broken
-- Lamia, Trolls, Mammols

g_mixins.weapon_break = function(weaponBreakMob)
    -- set default 10% chance to break weapon on critical hit taken
    -- this can be overridden in onMobSpawn

    weaponBreakMob:addListener('SPAWN', 'WEAPON_BREAK', function(mob)
        mob:setLocalVar('BreakChance', 10)
    end)

    -- chance to break weapon when taking a critical hit
    weaponBreakMob:addListener('CRITICAL_TAKE', 'BREAK_CRITICAL_TAKE', function(mob)
        if math.random(1, 100) <= mob:getLocalVar('BreakChance') then
            local animationSub = mob:getAnimationSub()

            -- break weapon
            if animationSub ~= 1 then
                mob:setAnimationSub(1)
            end
        end
    end)
end

return g_mixins.weapon_break
