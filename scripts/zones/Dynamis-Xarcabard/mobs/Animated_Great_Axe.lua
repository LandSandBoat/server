-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Great Axe
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)

    if (mob:getAnimationSub() == 3) then
        SetDropRate(104, 1576, 1000)
    else
        SetDropRate(104, 1576, 0)
    end

    target:showText(mob, ID.text.ANIMATED_GREATAXE_DIALOG)

    SpawnMob(17330383):updateEnmity(target)
    SpawnMob(17330384):updateEnmity(target)
    SpawnMob(17330385):updateEnmity(target)
    SpawnMob(17330395):updateEnmity(target)
    SpawnMob(17330396):updateEnmity(target)
    SpawnMob(17330397):updateEnmity(target)

end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_GREATAXE_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_GREATAXE_DIALOG+1)

    DespawnMob(17330383)
    DespawnMob(17330384)
    DespawnMob(17330385)
    DespawnMob(17330395)
    DespawnMob(17330396)
    DespawnMob(17330397)

end

return entity
