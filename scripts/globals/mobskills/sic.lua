-----------------------------------
-- Sic
-- Commands pet to use one of their abilities
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID()+1) -- Fantoccini's monster
        pet:setTP(3000)
        pet:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[mob:getMainJob()].petSkillList)
        mob:timer(5000, function(mobArg)
            pet:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    end

    return 0
end

return mobskill_object
