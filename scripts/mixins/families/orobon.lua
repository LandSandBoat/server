require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.orobon = function(orobonMob)
    -- 10% chance to break eyestalks on critical hit
    orobonMob:addListener('CRITICAL_TAKE', 'OROBON_CRITICAL_TAKE', function(mob)
        if
            mob:getAnimationSub() == 0 and
            math.random(1, 100) <= 10
        then
            mob:setAnimationSub(1)
        end
    end)

    -- Add Orobon Lures to loot pool if eyestalks are broken
    orobonMob:addListener('ITEM_DROPS', 'OROBON_ITEM_DROPS', function(mob, loot)
        if mob:getAnimationSub() == 1 then
            loot:addItem(xi.item.OROBON_LURE, xi.drop_rate.GUARANTEED)
        end
    end)
end

return g_mixins.families.orobon
