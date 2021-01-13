-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Shield
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(113, 1822, 1000)
    else
        SetDropRate(113, 1822, 0)
    end

    target:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG)

    SpawnMob(17330290):updateEnmity(target)
    SpawnMob(17330291):updateEnmity(target)
    SpawnMob(17330292):updateEnmity(target)
    SpawnMob(17330299):updateEnmity(target)
    SpawnMob(17330300):updateEnmity(target)
    SpawnMob(17330301):updateEnmity(target)

end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG+2)
end

entity.onMobDeath = function(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_SHIELD_DIALOG+1)

    DespawnMob(17330290)
    DespawnMob(17330291)
    DespawnMob(17330292)
    DespawnMob(17330299)
    DespawnMob(17330300)
    DespawnMob(17330301)

end

return entity
