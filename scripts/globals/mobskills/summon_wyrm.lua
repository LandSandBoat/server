---------------------------------------------
--  Summon Wyrm
--  Family: Bahamut
--  Description: Summons a random CoP Wyrm to fight with Bahamut.
--  Type: Summoning
--  Notes: Used by Bahamut at 80%, 60%, 40%, 20% of its HP.
---------------------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local randWyrm = mob:getLocalVar("randWyrm")
    local pet = GetMobByID(ID.mob.BAHAMUT_V2 + randWyrm)

    pet:spawn()
    pet:updateEnmity(target)
    skill:setMsg(xi.msg.basic.NONE)
    mob:setLocalVar("summoning", 0)

    return 0
end

return mobskill_object
