-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Claymore
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(102, 1574, 1000)
    else
        SetDropRate(102, 1574, 0)
    end

    target:showText(mob, ID.text.ANIMATED_CLAYMORE_DIALOG)

    SpawnMob(17330365):updateEnmity(target)
    SpawnMob(17330366):updateEnmity(target)
    SpawnMob(17330367):updateEnmity(target)
    SpawnMob(17330372):updateEnmity(target)
    SpawnMob(17330373):updateEnmity(target)
    SpawnMob(17330374):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_CLAYMORE_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_CLAYMORE_DIALOG+1)

    DespawnMob(17330365)
    DespawnMob(17330366)
    DespawnMob(17330367)
    DespawnMob(17330372)
    DespawnMob(17330373)
    DespawnMob(17330374)

end
