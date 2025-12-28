require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.khimaira = function(khimairaMob)
    -- 5% chance to bring wings down on critical hit
    -- TODO: Unknown if 5% chance is correct
    khimairaMob:addListener('CRITICAL_TAKE', 'KHIMAIRA_CRITICAL_TAKE', function(mob)
        local random = math.random(1, 100)

        if random <= 5 and mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
        end
    end)
end

return g_mixins.families.khimaira
