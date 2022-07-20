-----------------------------------
-- Pollen
--
-- Description: Restores HP.
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()
    local id = mob:getID()

    if (potency == 0) then
        potency = 12
    end

    potency = potency - math.random(0, potency/4)

    if -- KSNM Infernal Swarm
        id == 17621248 or -- IDs for Beelzebub
        id == 17621258 or
        id == 17621268
    then
        print("found ID")
        potency = 55
        potency = potency - math.random(0, 5)
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskill_object
