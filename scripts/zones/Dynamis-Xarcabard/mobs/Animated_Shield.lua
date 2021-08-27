-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Shield
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(113, 1822, 1000)
    else
        SetDropRate(113, 1822, 0)
    end

    target:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG)
end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG+2)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG+1)
end

return entity
