-----------------------------------
-- Area: Mine Shaft 2716
-- Quest: Return to the Depths
-- NM: Moblin Clergyman (x3)
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local entity = {}

local function getBoss(mob)
    local entityQuery = mob:getZone():queryEntitiesByName("Twilotak")
    local results = {}
    for _, r in pairs(entityQuery) do
        if r:isMob() then
            table.insert(results, r)
        end
    end
    return results[mob:getBattlefield():getArea()]
end

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 90)

    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)

    mob:setLocalVar("[depths]doAnimation", 0)
    mob:setLocalVar("[depths]castActivate", 0)

    mob:addListener("MAGIC_START", "MOBLIN_MAGIC_START", function(clergyman, spell)
        if mob:getLocalVar("[depths]doAnimation") == 0 then
            mob:setLocalVar("[depths]doAnimation", 1345)
        end
    end)

    mob:addListener("MAGIC_STATE_EXIT", "MOBLIN_MAGIC_EXIT", function(clergyman, spell)
        if getBoss(mob):getLocalVar("[depths]doAnimation") == 0 then
            getBoss(mob):setLocalVar("[depths]doAnimation", 1344)
            mob:setLocalVar("[depths]castActivate", 0)
        end
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobMagicPrepare = function(mob, target, spell)
end

return entity
