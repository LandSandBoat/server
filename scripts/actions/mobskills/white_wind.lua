-----------------------------------
-- White Wind
-- Family: Puks
-- Description:
-- HP recovery on all nearby mobs centered on the user.
-- The higher the user's HP, the higher the HP recovery.
-- Only used by certain puks.
--
-- Player Blue Magic Version uses MaxHP instead of current HP: floor(MaxHP/7)*2
-- The math for mob version is the same but uses current HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return mob:getLocalVar('UsedWhiteWind')
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL_SECONDARY -- TODO: Capture msg
    params.baseHeal       = mob:getMaxHP()
    params.fTP = -- TODO: Could use more captures
    {
        { tp = 1000, modifier = 0.10 },
        { tp = 2000, modifier = 0.30 },
        { tp = 3000, modifier = 0.50 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
