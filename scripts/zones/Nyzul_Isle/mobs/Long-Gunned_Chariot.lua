-----------------------------------
--  MOB: Long Gunned Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Homing Missile
-----------------------------------
mixins = { require('scripts/mixins/families/chariot') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- local data = mob:getData('homing')
    -- sets homing missile variant
    -- data.HM = 1
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'HOMING_MISSILE_WEAPONSKILL_STATE_EXIT', function(chariotMob, skillid)
        if skillid == 2058 then
            chariotMob:setLocalVar('firstHit', 0)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
