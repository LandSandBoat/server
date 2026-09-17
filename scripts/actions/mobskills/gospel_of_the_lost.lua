-----------------------------------
-- Gospel_of_the_Lost
-- Family: Avatar (Alexander)
-- Description: Self-heal (~1000 HP) and erase.
-- Notes: Accompanied by text
-- "Bask in my glory..."
-- "Mine existence...stretches into infinity..."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Lets not heal if we haven't taken any damage..
    if mob:getHPP() == 100 then -- TODO: Handle in mob script
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    mob:eraseStatusEffect()
    -- Didn't see any msg for the erase in youtube vids.

    local params = {}

    -- Assuming its a 4-6% heal based on its max HP and numbers quoted on wiki.
    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = mob:getMaxHP() * (math.randomInt(4, 6) * 0.01) -- TODO: Capture power
    params.fTP =
    {
        { tp = 1000, modifier = 1.00 },
        { tp = 2000, modifier = 1.00 },
        { tp = 3000, modifier = 1.00 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
