-----------------------------------
-- Sic
-- Commands pet to use one of their abilities
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID()+3):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID()+1) -- Fantoccini's monster
        pet:setTP(3000)
        pet:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[mob:getMainJob()].petSkillList)
        mob:timer(5000, function(mobArg)
            pet:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    else
        mob:getPet():setTP(3000)
    end
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
