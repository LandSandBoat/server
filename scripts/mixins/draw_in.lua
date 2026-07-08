require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.draw_in = function(mobArg)
    mobArg:addListener('COMBAT_TICK', 'DRAW_IN_CHECK', function(mob)
        local target = mob:getTarget()
        if target then
            local drawInTable =
            {
                conditions =
                {
                    mob:checkDistance(target) >= mob:getMeleeRange(target) * 2,
                },
                position = mob:getPos(),
            }
            utils.drawIn(target, drawInTable)
        end
    end)
end

return g_mixins.draw_in
