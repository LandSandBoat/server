-----------------------------------
-- Area: Misareaux Coast
--   NM: Ziphius
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 445)
end

return entity
