-----------------------------------
--  MOB: Shielde Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Mortal Revolution
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMonsterAbilityPrepare(mob)
    local target = mob:getTarget()

    if mob:getHPP() > 25 then
        return 0
    elseif math.random(1, 2) == 2 then
        return 2057 -- Mortal Revolution
    end

    return ({2055, 2056})[math.random(1, 2)]
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
