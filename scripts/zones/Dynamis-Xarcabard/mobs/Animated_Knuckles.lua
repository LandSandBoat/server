-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Knuckles
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(108, 1571, 1000)
    else
        SetDropRate(108, 1571, 0)
    end

    target:showText(mob, ID.text.ANIMATED_KNUCKLES_DIALOG)

    SpawnMob(17330309):updateEnmity(target)
    SpawnMob(17330310):updateEnmity(target)
    SpawnMob(17330311):updateEnmity(target)
    SpawnMob(17330319):updateEnmity(target)
    SpawnMob(17330320):updateEnmity(target)
    SpawnMob(17330321):updateEnmity(target)

end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_KNUCKLES_DIALOG+2)
end

entity.onMobDeath = function(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_KNUCKLES_DIALOG+1)

    DespawnMob(17330309)
    DespawnMob(17330310)
    DespawnMob(17330311)
    DespawnMob(17330319)
    DespawnMob(17330320)
    DespawnMob(17330321)

end

return entity
