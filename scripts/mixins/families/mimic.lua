require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.mimic = function(mimicMob)
    mimicMob:addListener('COMBAT_TICK', 'DRAW_IN_CHECK', function(mob)
        local target = mob:getTarget()
        if target then
            local drawInTable =
            {
                conditions =
                {
                    mob:checkDistance(target) >= mob:getMeleeRange(target),
                },
                position = mob:getPos(),
                offset = mob:getMeleeRange(target) - 0.2, -- TODO: does this change by target size?
            }
            utils.drawIn(target, drawInTable)
        end
    end)
end

return g_mixins.families.mimic
