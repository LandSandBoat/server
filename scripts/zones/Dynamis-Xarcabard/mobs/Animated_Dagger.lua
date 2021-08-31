-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Dagger
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(103, 1572, 1000)
    else
        SetDropRate(103, 1572, 0)
    end

    target:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG)

end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG+2)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG+1)
end

return entity
