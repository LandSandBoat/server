-----------------------------------
-- Family: Goblin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        { xi.mobSkill.GOBLIN_RUSH_1, 45 },
        { xi.mobSkill.BOMB_TOSS_1,   45 },
    }

    -- NMs should not suicide.
    -- TODO: Implement NM specific onMobMobskillChoose
    if not mob:isMobType(xi.mobType.NOTORIOUS) then
        table.insert(skills, { xi.mobSkill.BOMB_TOSS_SUICIDE, 10 })
    end

    local totalWeight = 0
    for _, v in ipairs(skills) do
        totalWeight = totalWeight + v[2]
    end

    local roll, sum = math.random(1, totalWeight), 0
    for _, v in ipairs(skills) do
        sum = sum + v[2]
        if roll <= sum then
            return v[1]
        end
    end
end

return entity
