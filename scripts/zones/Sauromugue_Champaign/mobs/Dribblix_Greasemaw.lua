-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Dribblix Greasemaw
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        not player:hasKeyItem(xi.ki.SEEDSPALL_VIRIDIS) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        player:addKeyItem(xi.ki.SEEDSPALL_VIRIDIS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_VIRIDIS)
    end
end

return entity
