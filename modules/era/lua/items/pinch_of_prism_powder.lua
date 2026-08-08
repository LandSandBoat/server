-----------------------------------
-- Restores the random Invisible duration (1 minute 30 seconds to 6 minutes).
-- Changed December 7th, 2010 : https://www.playonline.com/pcd/verup/ff11/detail/6024/detail.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_prism_powder_duration'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.items.pinch_of_prism_powder.onItemUse', function(target, user)
    if target:hasStatusEffect(xi.effect.INVISIBLE) then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end

    target:addStatusEffect(xi.effect.INVISIBLE, { power = 1, duration = math.floor(math.random(90, 360) * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
end)

return m
