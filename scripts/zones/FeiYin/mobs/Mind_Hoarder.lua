-----------------------------------
-- Area: Fei'Yin
--  Mob: Mind Hoarder
-----------------------------------
require("scripts/globals/titles");
-----------------------------------

function onMobDeath(mob, player, isKiller)

    -- Curses, Foiled A-Golem!?
    if (player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)) then
        player:delKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL);
        player:addKeyItem(tpz.ki.SHANTOTTOS_EXSPELL);
    end

end;
