require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.imp = function(impMob)
    -- 20% chance to break horn on critical hit
    -- Reacquires horn in stages of 30, 35, 40, 45, and a very rare 60 seconds
    impMob:addListener('CRITICAL_TAKE', 'IMP_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)

        if random <= 20 and mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
            if mob:getLocalVar('hornDisabled') ~= 1 then
                local time = 25 + (math.ceil(random / 5) * 5)

                if random <= 2 then
                    time = 60
                end

                mob:timer(time * 1000, function(mobArg)
                    if mob:isAlive() then
                        mob:setAnimationSub(0)
                    end
                end)
            end
        end
    end)
end

return g_mixins.families.imp
