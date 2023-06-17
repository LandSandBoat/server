-----------------------------------
-- Area: Batallia Downs
--  Mob: Vegnix Greenthumb
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        not player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        player:addKeyItem(xi.ki.SEEDSPALL_ROSEUM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_ROSEUM)
    end
end

return entity
