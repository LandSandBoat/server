-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Bugbby
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local aCenturyOfHardship =
{
    [1] =
    {
        MOBLIN_IDS = { 16830465, 16830466, 16830467, 16830468 }
    },
    [2] =
    {
        MOBLIN_IDS = { 16830470, 16830471, 16830472, 16830473 }
    },
    [3] =
    {
        MOBLIN_IDS = { 16830475, 16830476, 16830477, 16830478 }
    },
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MIGHTY_STRIKES, cooldown = 300, hpp = math.random(85, 95)}, -- 5min cooldown
        },
    })
end

entity.onMobFight = function(mob, target)
    local activeMoblins = {} -- clear list prior to checking
    local hateReset = mob:getLocalVar("hateResetTimer")
    local timeBlock = mob:getBattleTime() / 60 -- every 60 seconds, a random moblin calls for bugbby to attack their target

    if hateReset == 0 then
        hateReset = 1
        mob:setLocalVar("hateResetTimer", hateReset)
    end

    if timeBlock >= hateReset then
        local bfID = mob:getBattlefield():getArea()
        mob:setLocalVar("hateResetTimer", hateReset + 1)
        for i, v in ipairs(aCenturyOfHardship[bfID].MOBLIN_IDS) do
            local moblinAlive = GetMobByID(v)
            if moblinAlive:isAlive() then -- make sure we're not adding dead moblins into the table
                table.insert(activeMoblins, v)
            end
        end
        if #activeMoblins > 0 then
            local randMoblin = GetMobByID(activeMoblins[math.random(#activeMoblins)]) -- choose random moblin from activeMoblins
            mob:disengage()
            mob:resetEnmity(target)
            mob:updateEnmity(randMoblin:getTarget()) -- attack the chosen random moblin's target
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

return entity
