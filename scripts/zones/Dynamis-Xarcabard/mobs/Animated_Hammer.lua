-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Hammer
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

function onMobEngaged(mob, target)

    if (mob:AnimationSub() == 3) then
        SetDropRate(106, 1581, 1000)
    else
        SetDropRate(106, 1581, 0)
    end

    target:showText(mob, ID.text.ANIMATED_HORN_DIALOG)

    SpawnMob(17330334):updateEnmity(target)
    SpawnMob(17330335):updateEnmity(target)
    SpawnMob(17330336):updateEnmity(target)
    SpawnMob(17330344):updateEnmity(target)
    SpawnMob(17330345):updateEnmity(target)
    SpawnMob(17330346):updateEnmity(target)

end

function onMobFight(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_HORN_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_HORN_DIALOG+1)

    DespawnMob(17330334)
    DespawnMob(17330335)
    DespawnMob(17330336)
    DespawnMob(17330344)
    DespawnMob(17330345)
    DespawnMob(17330346)

end
