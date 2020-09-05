-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Dagger
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(103, 1572, 1000)
    else
        SetDropRate(103, 1572, 0)
    end

    target:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG)

    SpawnMob(17330306):updateEnmity(target)
    SpawnMob(17330307):updateEnmity(target)
    SpawnMob(17330308):updateEnmity(target)
    SpawnMob(17330316):updateEnmity(target)
    SpawnMob(17330317):updateEnmity(target)
    SpawnMob(17330318):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_DAGGER_DIALOG+1)

    DespawnMob(17330306)
    DespawnMob(17330307)
    DespawnMob(17330308)
    DespawnMob(17330316)
    DespawnMob(17330317)
    DespawnMob(17330318)

end
