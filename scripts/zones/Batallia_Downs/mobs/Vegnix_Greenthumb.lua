-----------------------------------
-- Area: Batallia Downs
--  Mob: Vegnix Greenthumb
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (not player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY)) then
        player:addKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_ROSEUM)
    end
end

return entity
