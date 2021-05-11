-----------------------------------
-- Area: Abyssea-Attohwa
--  Mob: Murrain Chigoe
-- Note: This mob does not need chigoe mixin
-- TODO: En-Disease
-----------------------------------
mixins = {require("scripts/mixins/families/chigoe")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
