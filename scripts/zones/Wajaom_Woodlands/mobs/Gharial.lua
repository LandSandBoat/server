-----------------------------------
-- Area: Wajaom Woodlands
--   NM: Gharial
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMod(xi.mod.MOVE_SPEED_STACKABLE, 12)
end

entity.onMobSpawn = function(mob)
    -- NM: Gharial will always use Boiling Blood immediately after Demoralizing Roar.
    -- https://www.youtube.com/watch?v=CyTY32jS9pU
    -- https://ffxiclopedia.fandom.com/wiki/Gharial

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'USE_BOILING_BLOOD', function(mobArg, skillId)
        local roarAbility  = 2101
        local boilingBlood = 2102

        if skillId == roarAbility then
            mobArg:useMobAbility(boilingBlood)
        end
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 450)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(7200 + math.random(0, 600)) -- 2 hours, then 10 minute window
end

return entity
