-----------------------------------
-- Restores the random Sneak duration (1 minute 30 seconds to 6 minutes).
-- Changed December 7th, 2010 : https://www.playonline.com/pcd/verup/ff11/detail/6024/detail.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_silent_oil_duration', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.items.pot_of_silent_oil.onItemUse', function(target, user)
    if not target:hasStatusEffect(xi.effect.SNEAK) then
        target:addStatusEffect(xi.effect.SNEAK, { power = 1, duration = math.floor(math.random(90, 360) * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
    end
end)
