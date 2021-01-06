-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Gun
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)

    if (mob:getAnimationSub() == 3) then
        tpz.core.setDropRate(105, 1585, 1000)
    else
        tpz.core.setDropRate(105, 1585, 0)
    end

    target:showText(mob, ID.text.ANIMATED_GUN_DIALOG)

    SpawnMob(17330513):updateEnmity(target)
    SpawnMob(17330514):updateEnmity(target)
    SpawnMob(17330515):updateEnmity(target)
    SpawnMob(17330516):updateEnmity(target)
    SpawnMob(17330517):updateEnmity(target)
    SpawnMob(17330518):updateEnmity(target)

end

entity.onMobFight = function(mob, target)
    -- TODO: add battle dialog
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.ANIMATED_GUN_DIALOG+2)
end

function onMobDeath(mob, player, isKiller)

    player:showText(mob, ID.text.ANIMATED_GUN_DIALOG+1)

    DespawnMob(17330513)
    DespawnMob(17330514)
    DespawnMob(17330515)
    DespawnMob(17330516)
    DespawnMob(17330517)
    DespawnMob(17330518)

end

return entity
