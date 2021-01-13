-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Slasher
-- Note: PH for Tawny-fingered Mugberry
-----------------------------------
mixins = {require("scripts/mixins/families/tonberry")}
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 798, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 799, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 800, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TAWNY_FINGERED_MUGBERRY_PH, 5, 3600) -- 1 hour
end

return entity
