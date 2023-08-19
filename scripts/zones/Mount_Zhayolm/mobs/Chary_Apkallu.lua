-----------------------------------
-- Area: Mount Zhayolm
--   NM: Chary Apkallu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 456)
end

return entity
