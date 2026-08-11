-----------------------------------
-- Restores the fixed 3 minute Invisible duration.
-- Changed December 7th, 2010 : https://www.playonline.com/pcd/verup/ff11/detail/6024/detail.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_rainbow_powder_duration', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.items.pinch_of_rainbow_powder.onItemUse', function(target, user)
    if target:hasStatusEffect(xi.effect.INVISIBLE) then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end

    target:addStatusEffect(xi.effect.INVISIBLE, { power = 1, duration = math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
end)
