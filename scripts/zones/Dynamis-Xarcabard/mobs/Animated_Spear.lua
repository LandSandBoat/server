-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Spear
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(114, 1578, 1000)
    else
        SetDropRate(114, 1578, 0)
    end

    target:showText(mob, ID.text.ANIMATED_SPEAR_DIALOG)

    SpawnMob(17330423):updateEnmity(target)
    SpawnMob(17330424):updateEnmity(target)
    SpawnMob(17330425):updateEnmity(target)
    SpawnMob(17330435):updateEnmity(target)
    SpawnMob(17330436):updateEnmity(target)
    SpawnMob(17330437):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_SPEAR_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_SPEAR_DIALOG+1)

    DespawnMob(17330423)
    DespawnMob(17330424)
    DespawnMob(17330425)
    DespawnMob(17330435)
    DespawnMob(17330436)
    DespawnMob(17330437)

end
