-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Scythe
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(112, 1577, 1000)
    else
        SetDropRate(112, 1577, 0)
    end

    target:showText(mob, ID.text.ANIMATED_SCYTHE_DIALOG)

    SpawnMob(17330420):updateEnmity(target)
    SpawnMob(17330421):updateEnmity(target)
    SpawnMob(17330422):updateEnmity(target)
    SpawnMob(17330432):updateEnmity(target)
    SpawnMob(17330433):updateEnmity(target)
    SpawnMob(17330434):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_SCYTHE_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_SCYTHE_DIALOG+1)

    DespawnMob(17330420)
    DespawnMob(17330421)
    DespawnMob(17330422)
    DespawnMob(17330432)
    DespawnMob(17330433)
    DespawnMob(17330434)

end
