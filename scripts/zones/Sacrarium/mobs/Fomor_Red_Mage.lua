-----------------------------------
-- Area: Sacrarium
--  Mob: Fomor Red Mage
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
