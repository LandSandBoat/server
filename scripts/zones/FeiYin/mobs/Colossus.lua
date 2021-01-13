-----------------------------------
-- Area: FeiYin
--  Mob: Colossus
-- Note: PH for Goliath
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 715, 2, tpz.regime.type.GROUNDS)

    -- Curses, Foiled A-Golem!?
    if (player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)) then
        player:delKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)
        player:addKeyItem(tpz.ki.SHANTOTTOS_EXSPELL)
    end
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GOLIATH_PH, 10, 3600) -- 1 hour
end

return entity
