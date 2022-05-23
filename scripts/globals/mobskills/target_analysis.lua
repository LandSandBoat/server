---------------------------------------------
-- Target Analysis
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/settings/main")
local ID = require("scripts/zones/Sealions_Den/IDs")
local ID2 = require("scripts/zones/Apollyon/IDs")
---------------------------------------------
local mobskill_object = {}

local attributes =
{
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.CHR_DOWN,
}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()
    local id = mob:getID()
    local checkID = false

    for i = 0, 2 do
        if
            ID.mob.OMEGA_OFFSET + i == id or
            ID2.mob.APOLLYON_CS_MOB == id
        then
             checkID = true
        end
    end

    if checkID and
       mobhp > 25 or
       checkID and
       mob:getAnimationSub() == 1
    then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local drained = 0

    for i = 1,7 do
        if math.random(0,100) < 40 then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, attributes[i], 10, 3, 60))
            drained = drained + 1
        end
    end

    return drained
end

return mobskill_object

