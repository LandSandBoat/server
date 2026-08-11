-----------------------------------
-- Restores the random Deodorize duration (1 minute 30 seconds to 6 minutes).
-- Changed December 7th, 2010 : https://www.playonline.com/pcd/verup/ff11/detail/6024/detail.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_deodorizer_duration', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.items.flask_of_deodorizer.onItemUse', function(target, user)
    if not target:hasStatusEffect(xi.effect.DEODORIZE) then
        target:addStatusEffect(xi.effect.DEODORIZE, { power = 1, duration = math.random(90, 360), origin = user, tick = 10 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end)
