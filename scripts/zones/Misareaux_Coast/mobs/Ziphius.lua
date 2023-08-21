-----------------------------------
-- Area: Misareaux Coast
--   NM: Ziphius
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 445)
end

return entity
