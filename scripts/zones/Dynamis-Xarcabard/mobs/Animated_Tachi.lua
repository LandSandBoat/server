-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Tachi
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    target:showText(mob, ID.text.ANIMATED_TACHI_DIALOG)
end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, ID.text.ANIMATED_TACHI_DIALOG + 2)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.ANIMATED_TACHI_DIALOG + 1)
end

return entity
