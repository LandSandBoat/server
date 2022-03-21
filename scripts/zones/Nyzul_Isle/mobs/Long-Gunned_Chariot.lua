-----------------------------------
--  MOB: Long Gunned Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Homing Missile
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    local data = mob:getData('homing')
    -- sets homing missile variant
    data.HM = 1
    mob:addListener("WEAPONSKILL_STATE_EXIT", "HOMING_MISSILE_WEAPONSKILL_STATE_EXIT", function(mob, skillid)
        if skillid == 2058 then
            mob:setLocalVar("firstHit", 0)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
