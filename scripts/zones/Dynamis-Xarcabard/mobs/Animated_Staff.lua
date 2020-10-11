-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Staff
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(115, 1582, 1000)
    else
        SetDropRate(115, 1582, 0)
    end

    target:showText(mob, ID.text.ANIMATED_STAFF_DIALOG)

    SpawnMob(17330337):updateEnmity(target)
    SpawnMob(17330338):updateEnmity(target)
    SpawnMob(17330339):updateEnmity(target)
    SpawnMob(17330347):updateEnmity(target)
    SpawnMob(17330348):updateEnmity(target)
    SpawnMob(17330349):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_STAFF_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_STAFF_DIALOG+1)

    DespawnMob(17330337)
    DespawnMob(17330338)
    DespawnMob(17330339)
    DespawnMob(17330347)
    DespawnMob(17330348)
    DespawnMob(17330349)

end
