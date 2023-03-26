-----------------------------------
-- Area: Fei'Yin
--   NM: Altedour I Tavnazia
-----------------------------------
require("scripts/globals/titles")
local feiyinID = require("scripts/zones/FeiYin/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, feiyinID.text.ITS_FINALLY_OVER)
end

return entity
