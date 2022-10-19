-----------------------------------
-- Area: FeiYin
--   NM: Dabotz's Ghost
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player:hasKeyItem(xi.ki.AQUAFLORA3) then
        player:setCharVar("DabotzKilled", 1)
    end
end

return entity
