-----------------------------------
-- Area: Leujaoam Sanctum (Orichalcum Survey)
--  Mob: Qiqirn Miner
-----------------------------------
require("scripts/globals/assault")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    -- Qiqirn witnessed to have frequent triple and double attack, but lacked evidence
    -- of any penta attack.
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    xi.assault.adjustMobLevel(mob)

    -- Progress will be > 1 when a player has mined an orichalcum ore.
    --  This ensures they respawn aggressive if killed during this stage.
    if mob:getInstance():getProgress() > 1 then
        mob:setAggressive(true)
    else
        mob:setAggressive(false)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
