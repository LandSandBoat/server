-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Longsword
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(111, 1573, 1000)
    else
        SetDropRate(111, 1573, 0)
    end

    target:showText(mob, ID.text.ANIMATED_LONGSWORD_DIALOG)

    SpawnMob(17330355):updateEnmity(target)
    SpawnMob(17330356):updateEnmity(target)
    SpawnMob(17330357):updateEnmity(target)
    SpawnMob(17330362):updateEnmity(target)
    SpawnMob(17330363):updateEnmity(target)
    SpawnMob(17330364):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_LONGSWORD_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_LONGSWORD_DIALOG+1)

    DespawnMob(17330355)
    DespawnMob(17330356)
    DespawnMob(17330357)
    DespawnMob(17330362)
    DespawnMob(17330363)
    DespawnMob(17330364)

end
