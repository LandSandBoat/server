-----------------------------------
-- Area: Sacrarium
--  Mob: Fomor Beastmaster
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
