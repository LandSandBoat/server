-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Warder (NIN, WHM)
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if mob:getMainJob() == xi.job.NIN then
        mob:setLocalVar("BreakChance", 0) -- Nin mobs dont have a weapon to break
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobSkillTarget = function(target, mob, skill)
    local skillId = skill:getID()
    if skillId == 1733 or skillId == 1923 or skillId == 1736 or skillId == 1925 then
        if utils.chance(50) then
            local instance = mob:getInstance()
            for i, gateid in ipairs(ID.mob[IMPERIAL_AGENT_RESCUE].GATES) do
                local gate = GetMobByID(gateid, instance)
                if gate and gate:isAlive() and mob:checkDistance(gate) <= 10 and mob:isFacing(gate) then
                    return gate
                end
            end
        end
    end
    return target
end

return entity
