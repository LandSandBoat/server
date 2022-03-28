-----------------------------------
--  MOB: Shielde Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Mortal Revolution
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------
local entity = {}

entity.onMonsterAbilityPrepare = function(mob)
    local target = mob:getTarget()

    if mob:getHPP() > 25 then
        return 0
    elseif math.random(1, 2) == 2 then
        return 2057 -- Mortal Revolution
    end

    return ({2055, 2056})[math.random(1, 2)]
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
