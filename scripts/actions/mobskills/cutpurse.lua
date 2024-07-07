-----------------------------------
--  Cutpurse
--  Description: Unequips a random piece of equipment.
--  Type: Enfeebling
--  Ignore Shadows, Single target
--  Note: If it takes off main weapon, anything held in Sub slot is unequipped as well.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    end

    local slots = {}
    for slot = xi.slot.MAIN, xi.slot.BACK do
        table.insert(slots, slot)
    end

    slots = utils.shuffle(slots)
    for _, slot in pairs(slots) do
        if target:hasSlotEquipped(slot) then
            target:unequipItem(slot)
            if slot == xi.slot.MAIN then
                target:unequipItem(xi.slot.SUB)
            end

            skill:setMsg(xi.msg.basic.USES)
            return
        end
    end

    skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
end

return mobskillObject
