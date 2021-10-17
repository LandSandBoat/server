-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (NIN, WHM, BST)
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
require("scripts/globals/assault")
require("scripts/globals/utils")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.assaultUtil.adjustMobLevel(mob)
--    local instance = mob:getInstance()

    if mob:getMainJob() == xi.job.NIN then
        mob:setLocalVar("BreakChance", 0) -- Nin mobs dont have a weapon to break
    elseif mob:getMainJob() == xi.job.BST then
        mob:setPet(GetMobByID(mob:getID() + 1, instance))
    end
end

entity.onMobFight = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 800)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobSkillTarget = function(target, mob, skill)
    local triggerSkills = {1733, 1736, 1923, 1925}
    local skillID = skill:getID()
    if utils.contains(skillID, triggerSkills) then
        if math.random(0, 100) > 50 then
            local instance = mob:getInstance()
            for _, gateid in ipairs(ID.mob[xi.assaultUtil.mission.IMPERIAL_AGENT_RESCUE].GATES) do
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
