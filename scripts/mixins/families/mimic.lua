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
                    mob:checkDistance(target) >= mob:getMeleeRange(),
                },
                position = mob:getPos(),
                offset = mob:getMeleeRange() - 0.2,
            }
            utils.drawIn(target, drawInTable)
        end
    end)
end

return g_mixins.families.mimic
