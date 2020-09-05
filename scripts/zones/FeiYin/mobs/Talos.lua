-----------------------------------
-- Area: FeiYin
--  Mob: Talos
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/keyitems")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    tpz.regime.checkRegime(player, mob, 713, 2, tpz.regime.type.GROUNDS)
    -- Curses, Foiled A-Golem!?
    if (player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)) then
        player:delKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)
        player:addKeyItem(tpz.ki.SHANTOTTOS_EXSPELL)
    end

end
