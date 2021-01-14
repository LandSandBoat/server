-----------------------------------
-- Area: Balga's Dais
--  Mob: Black Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.BLACK_DRAGON_SLAYER)
end

return entity
