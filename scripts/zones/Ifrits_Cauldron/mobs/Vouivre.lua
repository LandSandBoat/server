-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 402)
end

return entity
