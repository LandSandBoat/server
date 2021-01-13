-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Dribblix Greasemaw
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if not player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:addKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_VIRIDIS)
    end
end

return entity
