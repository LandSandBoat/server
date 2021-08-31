-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Tachi
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(117, 1580, 1000)
    else
        SetDropRate(117, 1580, 0)
    end

    target:showText(mob, ID.text.ANIMATED_TACHI_DIALOG)
end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.ANIMATED_TACHI_DIALOG+2)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:showText(mob, ID.text.ANIMATED_TACHI_DIALOG+1)
end

return entity
