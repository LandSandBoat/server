-----------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
-----------------------------------
---@type TMobSkill
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

    local total = math.random(3, 5)
    local amount = 0
    local power = 0
    slots = utils.shuffle(slots)
    for _, slot in pairs(slots) do
        if target:hasSlotEquipped(slot) then
            target:unequipItem(slot)
            if slot == xi.slot.MAIN then
                target:unequipItem(xi.slot.SUB)
            end

            power = bit.bor(power, bit.lshift(1, slot))
            amount = amount + 1
            if amount >= total then
                break
            end
        end
    end

    if amount == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    end

    local encumbrance = target:getStatusEffect(xi.effect.ENCUMBRANCE_I)
    if encumbrance then
        power = bit.bor(encumbrance:getPower(), power)
        target:delStatusEffectSilent(xi.effect.ENCUMBRANCE_I)
    end

    target:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, power, 0, 60)
    skill:setMsg(xi.msg.basic.USES)
end

return mobskillObject
