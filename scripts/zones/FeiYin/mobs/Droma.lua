-----------------------------------
-- Area: FeiYin
--  Mob: Droma
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)

    tpz.regime.checkRegime(player, mob, 714, 2, tpz.regime.type.GROUNDS)
    -- Curses, Foiled A-Golem!?
    if (player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)) then
        player:delKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)
        player:addKeyItem(tpz.ki.SHANTOTTOS_EXSPELL)
    end

end

return entity
