-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (NIN, WHM, BST)
-----------------------------------
mixins = { require("scripts/mixins/weapon_break") }
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
require("scripts/globals/assault")
require("scripts/globals/utils")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    if mob:getMainJob() == xi.job.NIN then
        mob:setLocalVar("BreakChance", 0) -- Nin mobs dont have a weapon to break
    elseif mob:getMainJob() == xi.job.BST then
        local instance = mob:getInstance()
        local pet = mob:getID() + 1

        mob:setPet(GetMobByID(pet, instance))
        mob:timer(5000, function(mobArg)
            local pos = mob:getPos()
            GetMobByID(pet, instance):setSpawn(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2))
            SpawnMob(pet, instance)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobSkillTarget = function(target, mob, skill)
    local triggerSkills = { 1733, 1736, 1923, 1925 }
    local skillID = skill:getID()
    if utils.contains(skillID, triggerSkills) then
        if math.random(0, 100) > 50 then
            local instance = mob:getInstance()
            for _, gateid in ipairs(ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].GATES) do
                local gate = GetMobByID(gateid, instance)
                if
                    gate and
                    gate:isAlive() and
                    mob:checkDistance(gate) <= 10 and
                    mob:isFacing(gate)
                then
                    return gate
                end
            end
        end
    end

    return target
end

return entity
