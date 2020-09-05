-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Tabar
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(116, 1575, 1000)
    else
        SetDropRate(116, 1575, 0)
    end

    target:showText(mob, ID.text.ANIMATED_TABAR_DIALOG)

    SpawnMob(17330380):updateEnmity(target)
    SpawnMob(17330381):updateEnmity(target)
    SpawnMob(17330382):updateEnmity(target)
    SpawnMob(17330392):updateEnmity(target)
    SpawnMob(17330393):updateEnmity(target)
    SpawnMob(17330394):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_TABAR_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_TABAR_DIALOG+1)

    DespawnMob(17330380)
    DespawnMob(17330381)
    DespawnMob(17330382)
    DespawnMob(17330392)
    DespawnMob(17330393)
    DespawnMob(17330394)

end
