-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Longbow
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(110, 1583, 1000)
    else
        SetDropRate(110, 1583, 0)
    end

    target:showText(mob, ID.text.ANIMATED_LONGBOW_DIALOG)

    SpawnMob(17330522):updateEnmity(target)
    SpawnMob(17330523):updateEnmity(target)
    SpawnMob(17330524):updateEnmity(target)
    SpawnMob(17330525):updateEnmity(target)
    SpawnMob(17330526):updateEnmity(target)
    SpawnMob(17330527):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_LONGBOW_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_LONGBOW_DIALOG+1)

    DespawnMob(17330522)
    DespawnMob(17330523)
    DespawnMob(17330524)
    DespawnMob(17330525)
    DespawnMob(17330526)
    DespawnMob(17330527)

end
