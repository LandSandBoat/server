-----------------------------------
--  MOB: Long Gunned Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Homing Missile
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    local data = mob:getData('homing')
    -- sets homing missile variant
    data.HM = 1
    mob:addListener("WEAPONSKILL_STATE_EXIT", "HOMING_MISSILE_WEAPONSKILL_STATE_EXIT", function(mob, skillid)
        if skillid == 2058 then
            mob:setLocalVar("firstHit", 0)
        end
    end)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
